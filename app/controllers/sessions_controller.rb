class SessionsController < Devise::SessionsController
  include EncryptedField::ControllerAdditions

  def create
    p params[:user][:password]
    p "----------------here-"
    decrypted_password = decrypt_encrypted_field(params[:user][:password])

    params[:user][:password] = decrypted_password
    p "yes-------------------"
    p params[:user][:password]

    request.params[:user] = {username: params[:user][:username], password: decrypted_password}
    warden.clear_strategies_cache!(:scope => :user)
    super
  end
end