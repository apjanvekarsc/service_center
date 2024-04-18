class AdminUser < ApplicationRecord
  rolify :role_cname => 'AdminRole'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  #if ENV['DEVISE_AUTHENTICATE_WITH_LDAP'] == "true"
    #devise :ldap_authenticatable, :trackable
    #before_create :get_ldap_name
  #else
  devise :database_authenticatable, :password_expirable,
         :rememberable, :trackable, :validatable, :timeoutable, :session_limitable
  #end       

  validates :username,
  :uniqueness => {
    :case_sensitive => false
  }

  def name
    username
  end

end
