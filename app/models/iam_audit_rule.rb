class IamAuditRule < ActiveRecord::Base
  audited
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  belongs_to :iam_organisation
  
  validates_presence_of :log_bad_org_uuid, :enabled_at, :interval_in_mins
  
  validate :enabled_at_should_be_today#, unless: "enabled_at.nil?"
  validates :interval_in_mins, :inclusion => 1..30
  
  private
  
  def enabled_at_should_be_today
    errors.add(:enabled_at, 'should be today') unless enabled_at.beginning_of_day == Time.zone.today.beginning_of_day
  end
end
