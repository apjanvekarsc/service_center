class UserGroup < ApplicationRecord
  #include Approval2::ModelAdditions
  
  belongs_to :user
  belongs_to :group
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'AdminUser'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'AdminUser'

  validates_uniqueness_of :user_id, :scope => [:group_id,:approval_status]
  validates_presence_of :user_id, :group_id
end