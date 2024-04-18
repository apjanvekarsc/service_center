class IamOrganisation < ApplicationRecord
  # #include Approval2::ModelAdditions
  # #include OrgNotification

  # belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  # belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  # has_many :iam_audit_logs, :foreign_key => 'org_uuid', :primary_key => 'org_uuid', :class_name => 'IamAuditLog'

  # before_validation :squish_ips
  
  # validates_presence_of :name, :org_uuid, :on_vpn, :is_enabled, :email_id
  # validates_uniqueness_of :org_uuid, :scope => :approval_status
  # validates :on_vpn, length: { minimum: 1, maximum: 1 }
  # validate :check_email_addresses
  # validates_format_of :source_ips, :with => /\A\w[\w\-\(\)\.\r\n]*\z/, :allow_blank => true
  # validate :value_of_source_ips

  # validates_presence_of :cert_dn, :message => "Required when 'Is VPN On?' is not checked.", :if => '!is_vpn_on?'
  # validates_presence_of :source_ips, :message => "Required when 'Is VPN On?' is not checked.", :if => '!is_vpn_on?'
  # validate :absence_of_cert_dn, if: 'is_vpn_on?'

  # validates_length_of :name, maximum: 100
  # validates_length_of :org_uuid, maximum: 32
  # validates_length_of :cert_dn, maximum: 300
  # validates_length_of :email_id, maximum: 255
  # validates_format_of :name, :org_uuid, with: /\A[a-z|A-Z|0-9|\s|\.|\-]+\z/, message: "invalid format - expected format is : {[a-z|A-Z|0-9|\s|\.|\-]}"
  # validates_format_of :cert_dn, with: /\A[a-z|A-Z|0-9|\s|\.|\,|\-|\\|\/|\=|\*]+\z/, message: "invalid format - expected format is : {[a-z|A-Z|0-9|\s|\.|\,|\-|\\|\/|\=|\*]}", allow_blank: true

  # def template_variables
  #   { name: name, email: email_id, org_uuid: org_uuid , on_vpn: on_vpn, cert_dn: cert_dn, source_ips: source_ips}
  # end

  # def is_vpn_on?
  #   on_vpn == 'Y' ? true : false
  # end

  # def check_email_addresses
  #   invalid_ids = []
  #   value = email_id
  #   unless value.nil?
  #     value.split(/;\s*/).each do |email| 
  #       unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  #         invalid_ids << email
  #       end
  #     end
  #   end
  #   errors.add(:email_id, "is invalid") unless invalid_ids.empty?
  # end

  # def value_of_source_ips
  #   unless self.source_ips.nil?
  #     arr =  self.source_ips.lines.map(&:chomp)
  #     invalid_ips = []
  #     arr.each do |a|
  #       if (Resolv::IPv4::Regex =~ a) == nil
  #         invalid_ips << a
  #       end
  #     end
  #     errors.add(:source_ips, "Invalid IPs #{invalid_ips}") unless invalid_ips.empty?
  #   end
  # end

  # def squish_ips
  #   self.source_ips = source_ips.squeeze(' ').strip.each_line.reject{|x| x.strip == ''}.join if (!self.frozen? and !source_ips.nil?)
  # end
  
  # def absence_of_cert_dn
  #   errors.add(:cert_dn, "is not allowed when 'Is VPN On?' is checked") if cert_dn.present?
  # end
end