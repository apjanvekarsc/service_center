class SuCustomersController < ApplicationController
#  authorize_resource
  before_action :authenticate_user!
  before_action :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  include SuCustomersHelper
  
  def new
    @su_customer = SuCustomer.new
  end

  def create
    @su_customer = SuCustomer.new(params[:su_customer])
    if !@su_customer.valid?
      render "new"
    else
      @su_customer.created_by = current_user.id
      @su_customer.save!
      flash[:alert] = "Salary Upload Customer successfully #{@su_customer.approved_id.nil? ? 'created' : 'updated'} and is pending for approval"
      redirect_to @su_customer
    end
  end 

  def edit
    su_customer = SuCustomer.unscoped.find_by_id(params[:id])
    if su_customer.approval_status == 'A' && su_customer.unapproved_record.nil?
      params = (su_customer.attributes).merge({:approved_id => su_customer.id, :approved_version => su_customer.lock_version})
      su_customer = SuCustomer.new(params)
    end
    @su_customer = su_customer
  end

  def update
    @su_customer = SuCustomer.unscoped.find_by_id(params[:id])
    @su_customer.attributes = params[:su_customer]
    if !@su_customer.valid?
      render "edit"
    else
      @su_customer.updated_by = current_user.id
      @su_customer.save!
      flash[:alert] = 'Salary Upload Customer successfully modified and is pending for approval'
      redirect_to @su_customer
    end
    rescue ActiveRecord::StaleObjectError
      @su_customer.reload
      flash[:alert] = 'Someone edited the Salary Upload Customer the same time you did. Please re-apply your changes to the Salary Upload Customer'
      render "edit"
  end 

  def show
    @su_customer = SuCustomer.unscoped.find_by_id(params[:id])
  end

  def index
    if params[:advanced_search].present?
      su_customers = find_su_customers(params).order("id desc")
    else
      su_customers = (params[:approval_status].present? and params[:approval_status] == 'U') ? SuCustomer.unscoped.where("approval_status =?",'U').order("id desc") : SuCustomer.order("id desc")
    end
    @su_customers_count = su_customers.count
    @su_customers = su_customers.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @su_customer = SuCustomer.unscoped.find(params[:id]) rescue nil
    @audit = @su_customer.audits[params[:version_id].to_i] rescue nil
  end
  
  def approve
    @su_customer = SuCustomer.unscoped.find(params[:id]) rescue nil
    SuCustomer.transaction do
      approval = @su_customer.approve
      if @su_customer.save and approval.empty?
        flash[:alert] = "Salary Uplaod Customer record was approved successfully"
      else
        msg = approval.empty? ? @su_customer.errors.full_messages : @su_customer.errors.full_messages << approval
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to @su_customer
  end

  private

  def su_customer_params
    params.require(:su_customer).permit(:account_no, :customer_id, :customer_name, :pool_account_no, :pool_customer_id, 
                                        :is_enabled, :created_by, :updated_by, :created_at, :updated_at, 
                                        :lock_version, :approval_status, :last_action, :approved_version, :approved_id, 
                                        :max_distance_for_name, :ops_email, :rm_email)
  end
end
