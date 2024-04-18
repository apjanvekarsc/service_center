class Ability
  include CanCan::Ability

  def initialize(user_obj,group_name = nil)
    # The order of the below methods are much important
    @user = user_obj
    @user ||= User.new # guest @user (not logged in)
    @group = @user.groups.find_by_name(group_name) if @user.class.name == 'User'
    super_admin_permissions if @user.has_role? :super_admin
    admin_permissions if @user.has_role? :admin
    user_admin_permissions if @user.has_role? :user_admin
    approver_admin_permissions if @user.has_role? :approver_admin
    user_permissions(@user.group_model_list) if @user.has_role? :user
    editor_permissions(@user.group_model_list) if @user.has_role? :editor
    supervisor_permissions(@user.group_model_list) if @user.has_role? :supervisor
    tester_permissions(@user.group_model_list) if @user.has_role? :tester
    can :read, ActiveAdmin::Page, :name => "Dashboard"
  end

  def user_permissions(models)
    models.each do |model_name|
      can :read, model_name.constantize
      can :audit_steps, model_name.constantize
      can :try_login, model_name.constantize
      can :incoming_file_summary, model_name.constantize
      can :download_file, model_name.constantize
      can :view_raw_content, model_name.constantize
      can :download_ecol_response_file, model_name.constantize
      can [:audit_logs, :ecol_audit_logs], model_name.constantize
    end
    can :manage, UnapprovedRecord, approvable_type: @group.try(:model_list)
  end

  def editor_permissions(models)
    models.each do |model_name|
      can :read, model_name.constantize
      can :manage, model_name.constantize
      cannot :approve, model_name.constantize
      cannot :generate_response_file, model_name.constantize
      cannot :reject, model_name.constantize
      can :override_records, model_name.constantize
      can :skip_records, model_name.constantize
      can :approve_restart, model_name.constantize
      cannot :process_file, model_name.constantize
      cannot :ecol_process_file, model_name.constantize
      can :download_ecol_response_file, model_name.constantize
      cannot :reset, model_name.constantize
      can :resend_notification, model_name.constantize
      can :try_login, model_name.constantize
      can :add_user, model_name.constantize
      can :delete_user, model_name.constantize
      can :resend_password, model_name.constantize
      cannot :custom_approval_of_record, model_name.constantize
      can :download_attachment,model_name.constantize
    end
    can :manage, UnapprovedRecord, approvable_type: @group.try(:model_list)
  end

  def supervisor_permissions(models)
    models.each do |model_name|
      can :read, model_name.constantize
      can :approve, model_name.constantize
      can :hit_api, model_name.constantize
      can :destroy, model_name.constantize
      can :generate_response_file, model_name.constantize
      can :download_file, model_name.constantize
      can :view_raw_content, model_name.constantize
      can :download_ecol_response_file, model_name.constantize
      can :audit_steps, model_name.constantize
      can :incoming_file_summary, model_name.constantize
      can :reject, model_name.constantize
      cannot :override_records, model_name.constantize
      cannot :skip_records, model_name.constantize
      cannot :approve_restart, model_name.constantize
      can :process_file, model_name.constantize
      can :reset, model_name.constantize
      can [:audit_logs, :ecol_audit_logs], model_name.constantize
      can :pending_validation, model_name.constantize
      can :approve_ecol_trans, model_name.constantize
      can :approve_transaction, model_name.constantize
      can :override_transaction, model_name.constantize
      can :download_data, model_name.constantize
      can :custom_approval_of_record, model_name.constantize
      can :resend_password, model_name.constantize
      can :try_login, model_name.constantize
      can :add_user, model_name.constantize
      can :delete_user, model_name.constantize
      can :download_attachment,model_name.constantize
    end
    can :manage, UnapprovedRecord, approvable_type: @group.try(:model_list)
  end

  def tester_permissions(models)
    models.each do |model_name|
      can :read, Bank
      can :manage, Bank
    end
    can :manage, UnapprovedRecord, approvable_type: @group.try(:model_list)
  end

  def user_admin_permissions
    can :manage, User
    cannot :destroy, User
    can :manage, AdminUser, :id=>@user.id
    cannot :destroy, AdminUser
    cannot :create, AdminUser
    can :manage, UserRole
    cannot :destroy, UserRole
    can :manage, UserGroup
    cannot :destroy, UserGroup
  end

  def admin_permissions
    can :read, User
    cannot :destroy, AdminUser
    cannot :create, AdminUser
  end

  def super_admin_permissions
    can :manage, AdminUser
    cannot :destroy, AdminUser, :id=>@user.id
  end

  def approver_admin_permissions
    can :read, UserRole
    can :approve, UserRole
    can :read, UserGroup
    can :approve, UserGroup 
  end
end
