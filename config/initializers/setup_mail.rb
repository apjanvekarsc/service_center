#require 'uat_mail_interceptor'
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
      :address => ENV['SMTP_ADDRESS'],
      :user_name => ENV['SMTP_USERNAME'],
      :password => ENV['SMTP_PASSWORD'],
      :authentication => :login,
      :enable_starttls_auto => true
}
#ActionMailer::Base.register_interceptor(UatMailInterceptor)