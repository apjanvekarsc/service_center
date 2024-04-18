ActiveAdmin.register UserGroup do
  menu :parent => "User Config", :priority => 2
  permit_params :user_id, :group_id, :lock_version, :approval_status, :last_action, 
                :approved_id, :approved_version, :created_at, :updated_at, :created_by,
                :updated_by, :disabled

  filter :id
  filter :user , as: :select, collection: proc {User.all.sort_by(&:id)}
  filter :group, as: :select, collection: proc {Group.all.sort_by(&:id)}

  index do
    column "Id" do |user|
      link_to "#{user.id}","user_groups/#{user.id}"
    end
    column :user
    column :group
    column :disabled
    actions defaults: true do |post|
      link_to "approve", approve_admin_user_group_path(post), :method => :put if current_admin_user.has_role?(:approver_admin)
    end
  end

  show do |ad|
    attributes_table do
      row "Note" do |user|
        "This is Data"
      end
      row :user
      row :group
      row :disabled
      row :approval_status
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
    @user_group = UserGroup.unscoped.find(params[:id]) rescue nil
    UserGroup.transaction do
      approved_record = @user_group.approve
      if approved_record.save
        flash[:alert] = "User Group record was approved successfully"
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
        @collection = UserGroup.unscoped.where("approval_status=?",'U').order("id desc").page(params[:page]).per(10) 
      else
        @collection = UserGroup.unscoped.where("approval_status=?",'A').order("id desc").page(params[:page]).per(10)
      end
      super
    end

    def show
      @user_group = UserGroup.unscoped.find_by_id(params[:id])
    end

    def create
      @user_group = UserGroup.new(permitted_params[:user_group])
      @user_group.created_by = "2"
      @user_group.updated_by = "2"
      if !@user_group.valid?
        render "new"
      else
        @user_group.created_by = current_admin_user.id
        @user_group.save!
        flash[:alert] = 'User group successfully created and is pending for approval'
        redirect_to :action => 'show', :id => @user_group.id
      end
    end 

    def edit
      user_group = UserGroup.unscoped.find_by_id(params[:id])
      if user_group.approval_status == 'A' && user_group.unapproved_record.nil?
        params = ({:user_id => user_group.user_id, :group_id=> user_group.group_id,:disabled=>user_group.disabled}).merge({:approved_id => user_group.id,:approved_version => user_group.lock_version})
        user_group = UserGroup.new(params)
      end
      @user_group = user_group
    end
  
    def update
      @user_group = UserGroup.unscoped.find_by_id(params[:id])
      @user_group.attributes = permitted_params[:user_group]
      if !@user_group.valid?
        flash[:error] = @user_group.errors.full_messages
        render "edit"
      else
        @user_group.updated_by = current_admin_user.id
        @user_group.save!
        flash[:alert] = 'User group successfully modified and is pending for approval'
        redirect_to :action => 'show', :id => @user_group.id
      end
      rescue ActiveRecord::StaleObjectError
        @user_group.reload
        flash[:alert] = 'Someone edited the user group the same time you did. Please re-apply your changes to the user group.'
        render "edit"
    end
  end

  form :partial => "form"

  csv :download_links => true do
    column("User") {|dl| dl.user.try(:user_name)}
    column("Group") {|dl| dl.group.try(:name)}
    column("Disabled") {|dl| dl.disabled}
    column("Approval Status") {|dl| dl.approval_status}
    column("Created By") {|dl| dl.created_user.try(:name)}
    column("Updated By") {|dl| dl.updated_user.try(:name)}
    column("Created At") {|dl| dl.created_at}
    column("Updated At") {|dl| dl.updated_at}
  end
end
