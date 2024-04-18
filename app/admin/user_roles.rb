ActiveAdmin.register UserRole do
  menu :parent => "User Config", :priority => 1
  permit_params :user_id, :role_id, :lock_version, :approval_status, :last_action, 
                :approved_id, :approved_version, :created_at, :updated_at, :created_by,
                :updated_by

  filter :id
  filter :user , as: :select, collection: proc {User.all.sort_by(&:id)}
  filter :role, as: :select, collection: proc {Role.all.sort_by(&:id)}

  index do
    column "Id" do |user|
      link_to "#{user.id}","user_roles/#{user.id}"
    end
    column :user
    column :role
    actions defaults: true do |post|
      link_to "approve", approve_admin_user_role_path(post), :method => :put if current_admin_user.has_role?(:approver_admin)
    end
  end

  show do |ad|
    attributes_table do
      row "Note" do |user|
        "test this data"
      end
      row :id
      row :user
      row :role
      row "created_by" do |user|
        user.created_user.try(:name)
      end
      row "updated_by" do |user|
        user.updated_user.try(:name)
      end
      row :created_at
      row :updated_at
    end
  end

  member_action :approve, :method => :put do
    @user_role = UserRole.unscoped.find(params[:id]) rescue nil
    UserRole.transaction do
      approved_record = @user_role.approve
      if approved_record.save
        flash[:alert] = "User Role record was approved successfully"
      else
        msg = approved_record.errors.full_messages
        flash[:alert] = msg
        raise ActiveRecord::Rollback
      end
    end
    redirect_to :back
  end

  controller do
    def index
      if current_admin_user.has_role?(:approver_admin)
        @collection = UserRole.unscoped.where("approval_status=?",'U').order("id desc").page(params[:page]).per(10) 
      else
        @collection = UserRole.unscoped.where("approval_status=?",'A').order("id desc").page(params[:page]).per(10)
      end
      super
    end

    def show
      @user_role = UserRole.unscoped.find_by_id(params[:id])
    end

    def create
      p permitted_params[:user_role].merge(created_by: "2")
      p permitted_params[:user_role].merge(updated_by: "2")
      p "----------------------------------"
      p permitted_params[:user_role]
      p "-----------------------"
      @user_role = UserRole.new(permitted_params[:user_role])
      @user_role.created_by = "2"
      @user_role.updated_by = "2"
      @user_role.save!
      if !@user_role.valid?
        render "new"
      else
        @user_role.created_by = current_admin_user.id
        @user_role.save!
        flash[:alert] = 'User Role successfully created and is pending for approval'
        redirect_to :action => 'show', :id => @user_role.id
      end
    end 

    def edit
      user_role = UserRole.unscoped.find_by_id(params[:id])
      if user_role.approval_status == 'A' && user_role.unapproved_record.nil?
        params = ({:user_id => user_role.user_id, :role_id=> user_role.role_id}).merge({:approved_id => user_role.id,:approved_version => user_role.lock_version})
        user_role = UserRole.new(params)
      end
      @user_role = user_role
    end
  
    def update
      @user_role = UserRole.unscoped.find_by_id(params[:id])
      @user_role.attributes = permitted_params[:user_role]
      if !@user_role.valid?
        flash[:error] = @user_role.errors.full_messages
        render "edit"
      else
        @user_role.updated_by = current_admin_user.id
        @user_role.save!
        flash[:alert] = 'User Role successfully modified and is pending for approval'
        redirect_to :action => 'show', :id => @user_role.id
      end
      rescue ActiveRecord::StaleObjectError
        @user_role.reload
        flash[:alert] = 'Someone edited the user role the same time you did. Please re-apply your changes to the user role.'
        render "edit"
    end
  end

  form :partial => "form"

  csv :download_links => true do
    column("Id") {|user| user.id}
    column("User") {|dl| dl.user.try(:user_name)}
    column("Role") {|dl| dl.role.try(:name)}
    column("Approval Status") {|dl| dl.approval_status}
    column("Created By") {|dl| dl.created_user.try(:name)}
    column("Updated By") {|dl| dl.updated_user.try(:name)}
    column("Created At") {|dl| dl.created_at}
    column("Updated At") {|dl| dl.updated_at}
  end
end
