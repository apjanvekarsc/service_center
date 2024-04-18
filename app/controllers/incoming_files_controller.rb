require 'will_paginate/array'

class IncomingFilesController < ApplicationController
  authorize_resource
  before_action :authenticate_user!
  before_action :block_inactive_user!
  respond_to :json, :html
  include IncomingFileHelper
  include SuIncomingRecordsHelper

  def new
    @incoming_file = IncomingFile.new
    @sc_service = ScService.find_by_code(params[:sc_service])
  end

  def create
    @incoming_file = IncomingFile.new(params[:incoming_file])
    @sc_service = ScService.find_by_code(params[:sc_service])
    if @incoming_file.save
      flash[:alert] = "File is successfully uploaded and is pending for approval"
      redirect_to incoming_files_path(:sc_service => params[:sc_service])
    else
      flash[:notice] = @incoming_file.errors.full_messages
      render :new
    end
  end

  def audit_steps
    @file_record = IncomingFile.unscoped.find(params[:id])
    file_record_values = find_logs(params, @file_record)
    @file_record_values_count = file_record_values.count(:id)
    @file_record_values = file_record_values.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def index
    @sc_service = ScService.find_by_code(params[:sc_service])
    
    if params[:advanced_search].present?  && params[:approval_status] == 'U'
      incoming_files = find_incoming_files(params).where("approval_status =?",'U').order("id desc")
    elsif params[:advanced_search].present?
      incoming_files = find_incoming_files(params).order("id desc")
    else 
      incoming_files = (params[:approval_status].present? and params[:approval_status] == 'U') ? IncomingFile.unscoped.where("approval_status=? and service_name=?",'U',params[:sc_service]).order("id desc") : IncomingFile.order("id desc").where(:service_name => params[:sc_service])
    end 
    @files_count = incoming_files.count
    @incoming_files = incoming_files.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def view_raw_content
    @incoming_file = IncomingFile.unscoped.find_by_id(params[:id])
    file_extension = @incoming_file.file.file.extension
    file_path = @incoming_file.file_path + '/' + @incoming_file.file_name
    if File.file?(file_path)
      if file_extension == IncomingFile::ExtensionList[0]
        @raw_file_content = %x(cat -nb #{file_path})
        @result = {filename: @incoming_file.file_name, content: @raw_file_content}
        respond_to do |format|
          format.html
          format.json { render json: @result }
        end
      else
        @result = {filename: @incoming_file.file_name, content: "The File content is not available for csv files."}
      end
    else
      @result = {filename: @incoming_file.file_name, content: "The File content is not available after the File is picked for processing."}
      respond_to do |format|
        format.html
        format.json { render json: @result }
      end
    end
  end

  def show
    @incoming_file = IncomingFile.unscoped.find_by_id(params[:id])
    @skipped_count = @incoming_file.incoming_file_records.where(:status => "SKIPPED").count(:id)
  end

  def destroy
    @incoming_file = IncomingFile.unscoped.find_by_id(params[:id])
    if @incoming_file.status == "N"
      if @incoming_file.destroy
        FileUtils.rm_f @incoming_file.file.path
      end
    else
      flash[:alert] = "delete is disabled since the file has already been proccessed"
    end
    redirect_to incoming_files_path(:approval_status => 'U', :sc_service => @incoming_file.service_name)
  end

  def approve
    @incoming_file = IncomingFile.unscoped.find(params[:id]) rescue nil 
    IncomingFile.transaction do
      approval = @incoming_file.approve

      @incoming_file.update(pending_approval: "N",fault_code: "",fault_reason: "",fault_subcode: "") if @incoming_file.service_name == "ECOL" && @incoming_file.file_type == "ECOL_RMTRS"

      if @incoming_file.save and approval.empty?
        move_incoming_file(@incoming_file)
        flash[:alert] = "Incoming File record was approved successfully"
      else
        msg = approval.empty? ? @incoming_file.errors.full_messages : @incoming_file.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end

    if @incoming_file.service_name == "AML" && (@incoming_file.auto_upload?)
      redirect_to unapproved_records_path(group_name: 'inward-remittance',sc_service: 'AML')
    else
      redirect_to @incoming_file
    end
  end
  
  def download_file
    require 'uri/open-scp'
    @incoming_file = IncomingFile.find(params[:id])
    file_name = (params[:flag] == 'response' ? @incoming_file.try(:rep_file_name) : (params[:flag] == 'nack' ? @incoming_file.try(:nack_file_name) : ''))
    file_path = (params[:flag] == 'response' ? @incoming_file.try(:rep_file_path) : (params[:flag] == 'nack' ? @incoming_file.try(:nack_file_path) : ''))
    if params[:flag] == 'output_file'
      output_file = FmOutputFile.find_by_id(params[:file_id])
      file_name = output_file.try(:file_name)
      file_path = output_file.try(:file_path)
    end
    cmd = "scp://iibadm@#{ENV['CONFIG_SCP_IIB_FILE_MGR']}" unless ENV['CONFIG_SCP_IIB_FILE_MGR'] = '127.0.0.1'
    data = open("#{cmd}#{file_path}/#{file_name}").read rescue ""
    if data.to_s.empty?
      flash[:alert] = "File not found!"
      redirect_to @incoming_file
    elsif params[:view].present?
      render plain: data
    elsif params[:download].present?
      send_data data, :filename => file_name
    end
  end

  def download_ecol_response_file
    @incoming_file = IncomingFile.find(params[:id])
    download_path = @incoming_file.get_ecol_response_file_path
    begin
      send_file "#{download_path}/#{@incoming_file.rep_file_name}", :disposition => 'attachment'
    rescue Exception => e
      flash[:alert] = "Error Occurred: #{e}"
      redirect_to @incoming_file
    end
  end

  def call_api(params, uri)
    if params[:record_ids]
      @incoming_file = IncomingFile.find_by_file_name(params[:file])
      api_faraday_call(:post, uri ,@incoming_file.file_name, params[:record_ids])    
    else
      flash[:notice] = "You haven't selected any records!"
    end
  end

  def override_records
    uri = "/fm/incoming_files/override"
    call_api(params, uri)
    redirect_to :back
  end

  def skip_records
    uri = "/fm/incoming_files/skip_failed_records"
    call_api(params, uri)
    redirect_to :back
  end

  def approve_restart
    uri = "/fm/incoming_files/retry_failed_records"
    call_api(params, uri)
    redirect_to :back
  end

  def reject
    @incoming_file = IncomingFile.find(params[:id]) 
    uri = "/fm/incoming_files/reject"
    api_faraday_call(:put, uri, @incoming_file.file_name, nil)  
    redirect_to @incoming_file
  end

  def process_file
    @incoming_file = IncomingFile.find(params[:id]) 
    uri = "/fm/incoming_files/retry_file"
    api_faraday_call(:put, uri, @incoming_file.file_name, nil)
    redirect_to @incoming_file
  end

  def reset
    uri = "/fm/incoming_files/reset_records"
    call_api(params, uri)
    redirect_to :back
  end

  def generate_response_file
    @incoming_file = IncomingFile.find(params[:id]) 
    uri = "/fm/incoming_files/enqueue_response_file"
    api_faraday_call(:put, uri, @incoming_file.file_name, nil)
    redirect_to @incoming_file
  end

  def api_faraday_call(method, uri, fileName, reqBody)
    conn = Faraday.new(:url => ENV['CONFIG_URL_IIB_FILE_MGR'], :ssl => {:verify => false}) do |c|
      c.use Faraday::Request::UrlEncoded
      c.use Faraday::Response::Logger
      c.use Faraday::Adapter::NetHttp
    end
    response = faraday_method(conn,uri,method,fileName,reqBody)
    status_code = response.status
    status_line = response.body if response.headers['Content-Type'] == 'text/plain'
    status_line = "#{ENV['CONFIG_URL_IIB_FILE_MGR']}#{uri}" if status_code == 404
    status_line = "Accepted" if status_code == 202
    status_line = "Completed" if status_code == 200
        
    Rails.logger.error "Unexpected reply from #{ENV['CONFIG_URL_IIB_FILE_MGR']}#{uri}, received reply: #{response.body}" if status_code > 299

    flash[:alert] = "Status code: #{status_code} <br> Message: #{status_line}".html_safe
  end

  def faraday_method(conn, uri, method,fileName,reqBody)
    if method == :put
      conn.put uri do |req|
        req.params['fileName'] = fileName
      end
    elsif method == :post
      conn.post uri do |req|
        req.params['fileName'] = fileName
        req.headers['Content-Type'] = 'application/text'
        req.body = reqBody.join(',')
      end
    end
  end
  
  def output_file
    @fm_output_file = FmOutputFile.find_by_id(params[:file_id])
  end
  
  def ecol_process_file
    @incoming_file = IncomingFile.where(id: params[:id]).last
    if @incoming_file.present?
      @incoming_file.update(pending_approval: "N")
    end
    
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end

  end


  def incoming_file_params
    params.require(:incoming_file).permit(:file, :size_in_bytes, :line_count, :created_by, :updated_by, :status,
                  :lock_version, :file_name, :file_type, :service_name)
  end
end
