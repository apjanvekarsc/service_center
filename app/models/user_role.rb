class UserRole < ApplicationRecord
  include Approval2::ModelAdditions
  
  belongs_to :user
  belongs_to :role
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'AdminUser'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'AdminUser'
  
  validates_uniqueness_of :user_id, :scope => :approval_status
  validates_uniqueness_of :user_id #, :if=>"approved_record.nil?", :message=> 'A role already exists for the user'
  
  validates_presence_of :user_id,:role_id
end