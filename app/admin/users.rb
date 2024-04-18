ActiveAdmin.register User do
  menu :parent => "User Config", :priority => 0
  permit_params :email, :first_name, :last_name, :password, :password_confirmation, :remember_me,
                :username, :inactive, :title, :body, :role_id, :mobile_no, group_ids: []

  filter :id
  filter :username, :label=>"User Id"
  filter :email
  filter :first_name
  filter :last_name
  filter :mobile_no
  filter :inactive,  as: :select
  filter :created_at
  filter :updated_at
  filter :sign_in_count
  filter :role
  filter :groups_name, :as => :select, :collection => proc {(User::Groups).collect {|r| [r.humanize, r]}.sort}

  index do
    column "Id" do |user|
      link_to "#{user.id}","users/#{user.id}"
    end
          column "User Id" do |user|
      user.username
    end
    column :first_name
    column :last_name
    column :email
    column :mobile_no
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :inactive
    column :role
    column :groups do |u|
      u.groups.pluck(:name)
    end
    actions
  end

  show do |ad|
    attributes_table do
      row "User Id" do |user|
        user.username
      end
      row :first_name
      row :last_name
      row :email
      row :mobile_no
      row :current_sign_in_at
      row :last_sign_in_at
      row :sign_in_count
      row :inactive
      row :role
      row :groups do |u|
        u.groups.pluck(:name)
      end
      row :created_at
      row :updated_at
    end
  end
  
  controller do
    include EncryptedField::ControllerAdditions

    def create
      @user = User.new(permitted_params[:user])
      unless ([:authenticate_devise_with_ldap] || Rails.env.test?)
        @user.password = decrypt_encrypted_field(permitted_params[:user][:password])
        @user.password_confirmation = decrypt_encrypted_field(permitted_params[:user][:password_confirmation])
      end
      if !@user.valid?
        render "new"
      else
        @user.save!
        flash[:alert] = 'User successfully created!'
        redirect_to :action => 'show', :id => @user.id
      end
    end 

    def update
      @user = User.find_by_id(params[:id])
      @user.attributes = permitted_params[:user]
      unless (CONFIG[:authenticate_devise_with_ldap] || Rails.env.test?)
        @user.password = decrypt_encrypted_field(permitted_params[:user][:password])
        @user.password_confirmation = decrypt_encrypted_field(permitted_params[:user][:password_confirmation])
      end
      if !@user.valid?
        flash[:error] = @user.errors.full_messages
        render "edit"
      else
        @user.save!
        flash[:alert] = 'User successfully modified!'
        redirect_to :action => 'show', :id => @user.id
      end
      rescue ActiveRecord::StaleObjectError
        @user.reload
        flash[:alert] = 'Someone edited the user the same time you did. Please re-apply your changes to the user.'
        render "edit"
    end
  end

  form :partial => "form"

  csv :download_links => true do
    column("Id") {|user| user.id}
    column("UserId") {|user| user.username}
    column("FirstName") {|user| user.first_name}
    column("LastName") {|user| user.last_name}
    column("Email") {|user| user.email}
    column("MobileNo") {|user| user.mobile_no}
    column("Current Sign In At") {|user| user.current_sign_in_at}
    column("Last sign In At") {|user| user.last_sign_in_at}
    column("Sign in count") {|user| user.sign_in_count}
    column("Inactive") {|user| user.inactive}
    column("Role") {|user| user.role}
    column("Groups") {|user| user.groups.collect{|group| group.name}}
  end
end
