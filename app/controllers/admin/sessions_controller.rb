class Admin::SessionsController < ActiveAdmin::Devise::SessionsController
  include EncryptedField::ControllerAdditions
  
  def create
    decrypted_password = decrypt_encrypted_field(params[:admin_user][:password])
    params[:admin_user][:password] = decrypted_password
    request.params[:admin_user] = {username: params[:admin_user][:username], password: decrypted_password}
    warden.clear_strategies_cache!(:scope => :admin_user)
    super
  end
end



