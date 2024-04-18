require 'will_paginate/array'

class IncomingFileRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :block_inactive_user!
  respond_to :json, :html
  include SuIncomingRecordsHelper
  
  def index
    records = IncomingFileRecord.where("incoming_file_id =? and status =?",params[:incoming_file_id],params[:status]).order("id desc")
    @records_count = records.count(:id)
    @records = records.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_steps
    @record = IncomingFileRecord.find(params[:id])
    record_values = find_logs(params, @record)
    @record_values_count = record_values.count(:id)
    @record_values = record_values.paginate(:per_page => 10, :page => params[:page]) rescue []
  end
end