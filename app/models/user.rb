class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_one :user_role
  has_many :user_groups, -> {where disabled: false}
  has_many :groups, :through => :user_groups

  devise :session_limitable, :timeoutable

  Roles = %w{user supervisor editor}

  Groups = %w{inward-remittance e-collect}

  validates :username, :presence => true,
  :uniqueness => {
    :message => "This user id already exists in the system.",
    :case_sensitive => false
  }

  # hack: for gems to work across console and sc
  def accessible_customers
    []
  end

  def role
    user_role.try(:role)
  end

  def group_names
    groups.pluck(:name) rescue []
  end

  def group_model_list
    list = []
    groups.each do |group|
      list << group.model_list
    end
    list.flatten rescue []
  end

  if ENV['DEVISE_AUTHENTICATE_WITH_LDAP'] == "true"
    devise :ldap_authenticatable, :trackable
    before_create :get_ldap_name
  else
    validates :email, :presence => true, :format => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  end

  def unregistered?
    if inactive
      return true
    end
    return false
  end

  def has_role?(role_name)
    role.try(:name) == role_name.to_s ? true : false
  end

  def name
    "#{first_name} #{last_name}(#{username})"
  end

  def sync_from_ldap
      if ENV['DEVISE_AUTHENTICATE_WITH_LDAP'] == "true"
      self.first_name = Devise::LdapAdapter.get_ldap_param(self.username, 'givenname') rescue nil
      self.last_name = Devise::LdapAdapter.get_ldap_param(self.username, 'sn') rescue nil
      self.email = Devise::LdapAdapter.get_ldap_param(self.username, 'mail') rescue "#{username}@ratnakarbank.in"
      self.mobile_no = Devise::LdapAdapter.get_ldap_param(self.username, 'mobile') rescue nil
    end
  end

  def get_ldap_name
    self.last_name = Devise::LdapAdapter.get_ldap_param(self.username, 'sn') rescue nil
    self.email = Devise::LdapAdapter.get_ldap_param(self.username, 'mail') rescue "#{username}@ratnakarbank.in"
    self.mobile_no = Devise::LdapAdapter.get_ldap_param(self.username, 'mobile') rescue nil
    if self.last_name.blank?
      errors.add(:username, "Invalid User Id")
      return false
    elsif self.first_name.blank?
      self.first_name = Devise::LdapAdapter.get_ldap_param(self.username, 'givenname') rescue nil
      errors.add(:username, "User Name: #{self.first_name} #{self.last_name}, Kindly validate name before creation.")
      return false
    end
    return true
  end
end
