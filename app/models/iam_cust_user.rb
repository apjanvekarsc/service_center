class IamCustUser < ApplicationRecord
  include Approval2::ModelAdditions
  #include UserNotification

  attr_accessor :generated_password, :skip_presence_validation

  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  
  validate :password_via?, :same_field_value_check?
  # validates :mobile_no,:secondary_mobile_no, format: { with: /\A\d+\z/, message: "Integer only." },if: :check_send_password_via_phn?

  validates_presence_of :username
  validates_presence_of :first_name,unless: :skip_presence_validation
  #validates_uniqueness_of :username,if: "approved_record.nil?", message: 'Username already present in the system'
  validates_length_of :username, :first_name, :last_name, maximum: 100
  validates_format_of :username, with: /\A[a-z|A-Z|0-9|\_|\.]+\z/, message: "invalid format - expected format is : {[a-z|A-Z|0-9|\_|\.]}"
  validates_format_of :first_name, with: /\A[a-z|A-Z|0-9|\s|\.|\-]+\z/, message: "invalid format - expected format is : {[a-z|A-Z|0-9|\s|\.|\-]}"
  validates_format_of :last_name, with: /\A[a-z|A-Z|0-9|\s|\.|\-]+\z/, message: "invalid format - expected format is : {[a-z|A-Z|0-9|\s|\.|\-]}", allow_blank: true
  validates_format_of :email,:secondary_email, with: /\A([\w\.-]+)@([\w\-]+\.)+([A-Z]{2,4})\Z/i,message: "invalid format - expected format is : {[a-z|A-Z|0-9._-]@[a-z|A-Z|0-9._-].[a-z|A-Z]{2,4}}", length: { maximum: 100 },if: :check_send_password_via_email?
  validates :mobile_no,:secondary_mobile_no, numericality: true, length: { minimum: 10,maximum: 13 },format: { with: /\A\d+\z/, message: "Integer only." },if: :check_send_password_via_phn?
  validates_format_of :email, with: /\A([\w\.-]+)@([\w\-]+\.)+([A-Z]{2,4})\Z/i,message: "invalid format - expected format is : {[a-z|A-Z|0-9._-]@[a-z|A-Z|0-9._-].[a-z|A-Z]{2,4}}", length: { maximum: 100 },if: :check_send_password_via_both?
  validates :mobile_no, numericality: true, length: { minimum: 10,maximum: 13 },format: { with: /\A\d+\z/, message: "Integer only." },if: :check_send_password_via_both?

  before_save :generate_password,:set_old_password_value

  def set_old_password_value
    if self.old_password == nil
      self.old_password = self.encrypted_password
    end 
  end


  def check_send_password_via_phn?
    if self.send_password_via == "sms"
      true
    end
  end

  def check_send_password_via_email?
    if self.send_password_via == "email"
      true
    end
  end

  def check_send_password_via_both?
    if self.send_password_via == "both"
      true
    end
  end

  def password_via?
    if send_password_via == "sms"
      mobile_no.blank? ? errors.add(:mobile_no,"Mobile No Can't be blank?") : nil
      secondary_mobile_no.blank? ? errors.add(:secondary_mobile_no,"Secondary Mobile No Can't be blank?") : nil
    elsif send_password_via == "email"
      email.blank? ? errors.add(:email,"Email Can't be blank?") : nil
      secondary_email.blank? ? errors.add(:secondary_email,"Secondary Email Can't be blank?") : nil
    elsif send_password_via == "both"
      email.blank? ? errors.add(:email,"Email Can't be blank?") : nil
      mobile_no.blank? ? errors.add(:mobile_no,"Mobile No Can't be blank?") : nil
    end
  end

  def same_field_value_check?
    if send_password_via == "sms" && (mobile_no.present? && secondary_mobile_no.present?)
      (mobile_no.strip == secondary_mobile_no.strip) ? errors.add(:secondary_mobile_no,"Mobile No & Secondary Mobile No can't be same!") : nil
    elsif send_password_via == "email" && (email.present? && secondary_email.present?)
      (email.strip == secondary_email.strip) ? errors.add(:secondary_email,"Email & Secondary Email Can't be same!") : nil
    end
  end

  def template_variables(event)
    if event == 'Password Generated'
      { username: username, first_name: first_name, last_name: last_name, mobile_no: mobile_no,secondary_mobile_no: secondary_mobile_no, email: email,secondary_email: secondary_email, password_part_1: password_part_1(decrypted_password), password_part_2: password_part_2(decrypted_password) }
    elsif event == 'Access Removed'
      { username: username, first_name: first_name, last_name: last_name, mobile_no: mobile_no, email: email }
    end
  end

  def password_part_1(passwd)
    passwd.slice(0..(passwd.length/2)-1)
  end

  def password_part_2(passwd)
    passwd.slice((passwd.length/2)..passwd.length)
  end

  
  #With this connection to LDAP is established
  # def will_connect_to_ldap
  #   LDAP.new
  #   return nil
  # rescue LdapFault, Psych::SyntaxError, SystemCallError, Net::LDAP::LdapError => e
  #   errors[:base] << "LDAP connection error : #{e.message}"
  # end
  
  def generate_password
    puts "==============================generate_password method start for username: #{username}========================="
    if self.last_action == 'C' && self.approval_status == 'A' && self.lock_version >= 0
      puts "-----------Fresh User------------"
      self.generated_password = [*('A'..'Z')].sample(4).join + rand(10..99).to_s + [*('a'..'z')].sample(4).join
      self.encrypted_password = EncPassGenerator.new(generated_password, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_encrypted_password
      self.last_password_reset_at = Time.zone.now
    elsif (self.last_action == 'U' || self.last_action =='C') && self.approval_status == 'A' && self.should_reset_password == "Y"
      puts "-----------Outside User Reset Password------------"
      group_check = LDAP.new.group_registration_check(username) rescue nil
      @message = self.test_ldap_login
      if (group_check.present? && group_check.include?(true)) && @message == "Login Successfull"
        puts "-----------Inside User Reset Password------------"
        self.generated_password = [*('A'..'Z')].sample(4).join + rand(10..99).to_s + [*('a'..'z')].sample(4).join
        self.encrypted_password = EncPassGenerator.new(generated_password, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_encrypted_password
        self.last_password_reset_at = Time.zone.now
      end
    end
  end
  
  def decrypted_password
    DecPassGenerator.new(encrypted_password,ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_decrypted_data
  end
  
  def decrypt_old_password(old_password)
    DecPassGenerator.new(old_password,ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_decrypted_data
  end

  
  def self.iam_cust_user_exists?(*args)
    args.size.zero? ? true : IamCustUser.find_by(username: args[0]).present?
  end
end