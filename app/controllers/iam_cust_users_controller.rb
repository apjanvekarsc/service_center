class IamCustUsersController < ApplicationController
#  authorize_resource
  before_action :authenticate_user!
  before_action :block_inactive_user!
  respond_to :json  
  include ApplicationHelper
  include Approval2::ControllerAdditions
  include IamCustUserHelper
  
  def new
    @iam_cust_user = IamCustUser.new
   # @iam_cust_user.will_connect_to_ldap
  end

  def create
    to_update_recod = IamCustUser.where(id: params[:iam_cust_user][:approved_id]).first
    
    if to_update_recod.present?
      params[:iam_cust_user].merge!(was_user_added: to_update_recod.was_user_added,encrypted_password: to_update_recod.encrypted_password,old_password: to_update_recod.encrypted_password)
    end

    @iam_cust_user = IamCustUser.new(params[:iam_cust_user])
    if !@iam_cust_user.valid?
      render "new"
    else
      @iam_cust_user.created_by = current_user.id
      @iam_cust_user.save!
      flash[:alert] = "User successfully created is pending for approval"
      redirect_to @iam_cust_user
    end
  end
  
  def edit
    @iam_cust_user.will_connect_to_ldap
  end

  def update

    @iam_cust_user = IamCustUser.unscoped.find_by_id(params[:id])
    @iam_cust_user.attributes = params[:iam_cust_user]
    if !@iam_cust_user.valid?
      render "edit"
    else
      @iam_cust_user.updated_by = current_user.id
      @iam_cust_user.save!
      flash[:alert] = 'User successfully modified and is pending for approval'
      redirect_to @iam_cust_user
    end
    rescue ActiveRecord::StaleObjectError
      @iam_cust_user.reload
      flash[:alert] = 'Someone edited the user the same time you did. Please re-apply your changes to the user.'
      render "edit"
  end

  def show
    @iam_cust_user = IamCustUser.unscoped.find_by_id(params[:id])
    @ldap_error = @iam_cust_user.will_connect_to_ldap
  end

  def index
    if params[:advanced_search].present?
      iam_cust_users = find_iam_cust_users(params).order("id DESC")
    else
     # iam_cust_users = (params[:approval_status].present? and params[:approval_status] == 'U') ? IamCustUser.unscoped.where("approval_status =?",'U').order("id desc") : IamCustUser.order("id desc")
    end
    @iam_cust_users = iam_cust_users.paginate(:per_page => 10, :page => params[:page]) rescue []
  end

  def audit_logs
    @iam_cust_user = IamCustUser.unscoped.find(params[:id]) rescue nil
    @audit = @iam_cust_user.audits[params[:version_id].to_i] rescue nil
  end
  
  def approve
    redirect_to unapproved_records_path(group_name: 'iam')
  end

  def try_login
    @iam_cust_user = IamCustUser.unscoped.find_by_id(params[:id])
    @message = @iam_cust_user.test_ldap_login
    return_message
  end

  def add_user
    @iam_cust_user = IamCustUser.unscoped.find_by_id(params[:id])
    @message = @iam_cust_user.was_user_added == "Y" ? 'User already present in LDAP' : @iam_cust_user.add_user_to_ldap
    return_message
  end

  def delete_user
    @iam_cust_user = IamCustUser.unscoped.find_by_id(params[:id])
    @message = @iam_cust_user.delete_user_from_ldap
    return_message
  end

  def resend_password
    @iam_cust_user = IamCustUser.unscoped.find_by_id(params[:id])
    @message = @iam_cust_user.resend_password
    return_message
  end

  def ldap_user_list
    @users_list = LDAP.new.list_users
  end

  private
  
  def return_message
    respond_to do |format|
      format.js {render file: 'iam_cust_users/message.js.haml'}
    end
  end

  def search_params
    params.permit(:page, :username, :email,:secondary_email, :mobile_no,:secondary_mobile_no, :approval_status)
  end

  def iam_cust_user_params
    params.require(:iam_cust_user).permit(:username, :first_name, :last_name, :email, :mobile_no, :last_password_reset_at, 
                                          :created_at, :updated_at, :created_by, :updated_by, :lock_version, :approved_id, :approved_version,
                                          :should_reset_password, :is_enabled,:secondary_email,:secondary_mobile_no,:send_password_via)
  end
end