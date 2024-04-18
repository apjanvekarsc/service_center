class SuCustomer < ActiveRecord::Base
  include Approval
  include SuApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :account_no, :customer_id, :customer_name, :pool_account_no, :pool_customer_id, :max_distance_for_name
  validates_numericality_of :account_no, :customer_id, :pool_account_no, :pool_customer_id, :message => 'Invalid format, expected format is : {[0-9]}'
  validates_uniqueness_of :account_no, :scope => [:customer_id, :approval_status]

  validates :max_distance_for_name, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
  validates :customer_name, format: {with: /\A[a-z|A-Z|0-9|\s|\.|\-]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\s|\.|\-]}'}, length: {maximum: 100}
  validates :customer_id, length: { maximum: 15 }
  [:account_no, :pool_account_no, :pool_customer_id].each do |column|
    validates column, length: { maximum: 20 }
  end
  [:ops_email, :rm_email].each do |column|
    validates column, length: { maximum: 100 }, :allow_blank => true
  end

  validate :check_email_addresses

  def check_email_addresses
    ["ops_email","rm_email"].each do |email_id|
      invalid_ids = []
      value = self.send(email_id)
      unless value.nil?
        value.split(/;\s*/).each do |email| 
          unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
            invalid_ids << email
          end
        end
      end
      errors.add(email_id.to_sym, "is invalid, expected format is abc@def.com") unless invalid_ids.empty?
    end
  end

end
