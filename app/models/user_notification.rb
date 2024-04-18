module UserNotification  
  extend ActiveSupport::Concern
  included do
    after_save :add_user_to_ldap_on_approval
    after_save :delete_user_from_ldap_on_approval
  end

  def test_ldap_login
    puts puts "================test_ldap_login method start for username: #{username}================"
    LDAP.new.try_login(username, decrypted_password)
    group_check = LDAP.new.group_registration_check(username) rescue nil
    puts "=========in test login block=========="
    puts "username==========#{username}==========="
    puts "Password============xxxxxxxxxxx========="
    puts "=========Group Check Value inside test_ldap_login method=======#{group_check}================="
    (group_check.present? && group_check.include?(true)) ? "Login Successfull" : "Login Successfull but User not present in Group"
  rescue LdapFault, Psych::SyntaxError, SystemCallError, Net::LDAP::LdapError => e
    puts "======================During test_ldap_login =================="
    puts "Message: #{e}"
    return e.message
   puts "============test login block end===================" 
  end
  
  def resend_password
    group_check = LDAP.new.group_registration_check(username) rescue nil
    @message = self.test_ldap_login
    puts "============LDAP Login message:- #{@message}==============="
    puts "================group_check value Inside resend_password method========>#{group_check}================"
    puts "=============================resend_password method start for username: #{username}=============================="
    notify = notify_customer('Password Generated') if (group_check.present? && group_check.include?(true)) && @message == "Login Successfull"
    puts "==============Password resend function value -----#{notify}"
    if notify == true
      return "Password has been resent successfully!" 
    end
    if group_check.blank?
      return "Password can't be resend since User not present in Group!"
    end
    @message_values = ["Login Successfull","Login Successfull but User not present in Group"]
    unless @message_values.include?(@message)
      return "Password can't be resend since faced #{@message} error while performing Test Login!"
    end
    if notify != true
      return notify
    end
    returned_notify_value = notify == true
    puts "=================Compare Notify Value: #{returned_notify_value}==========="
  rescue OCIError, ArgumentError => e
    puts e.message
  end
  
  # Manually adding user in LDAP
  def add_user_to_ldap
    puts "=============================add_user_to_ldap method start for username: #{username}=============================="
    begin
      puts "================Add User to LDAP Password Process Initiated================="
      puts "============add_user username==========>#{username}========================="
      
      LDAP.new.add_user(username, decrypted_password)
    rescue LdapFault, Psych::SyntaxError, SystemCallError, Net::LDAP::LdapError, OCIError, ArgumentError => error
      if error.code == 68
        LDAP.new.delete_user(username)
        retry
      end
      puts "================Add User Error code: #{error}================"
      puts "================Failure adding user to LDAP================"
      puts "===============Was User Added to LDAP value after Failure response: #{was_user_added}==================="
      return error.message
    else
      puts "==================Success in Adding User to LDAP========================"
      update_column(:was_user_added, 'Y')
      notify = notify_customer('Password Generated') unless Rails.env.test?
      notify == true ? "Entry added successfully to LDAP for #{username} and notification sent!" : "Entry added successfully to LDAP for #{username}!"
      puts "==========Notify Value: #{notify}======================="
      puts "===============Was User Added to LDAP value after Success response: #{was_user_added}==================="
      return "User Manually Added To LDAP"
    ensure
      puts "================Add User to LDAP Execution Completed================"
    end
  end
  

  def delete_user_from_ldap
    puts "=============================delete_user_from_ldap method start for username: #{username}=============================="
    if is_enabled == 'N'
      begin
        puts "================Delete User to LDAP Password Process Initiated================="
        puts "============delete_user username==========>#{username}========================="
        LDAP.new.delete_user(username)
      rescue Exception => error
        puts "================Delete User Error code: #{error}================"
        puts "================Failure deleting user from LDAP================"
        return error.message
      else
        puts "==================Success in Deleting User from LDAP========================"
        update_column(:was_user_added, 'N')
        notify = notify_customer('Access Removed') unless Rails.env.test?
        notify == true ? "Entry deleted from LDAP for #{username} and notification sent!" : "Entry deleted from LDAP for #{username}!"
      ensure
        puts "================Delete User to LDAP Execution Completed================"
      end
    end
  end

  #User is added to LDAP on approval
  def add_user_to_ldap_on_approval
    puts "================add_user_to_ldap_on_approval method start for username: #{username}================"
    if approval_status == 'A' && should_reset_password == "Y"
      group_check = LDAP.new.group_registration_check(username) rescue nil
      puts "================group_check value Inside add_user_to_ldap_on_approval method for Reset Password Block========>#{group_check}================"
      if (group_check.present? && group_check.include?(true))
        puts "================Reset Password Block start================"
        begin
          puts "================Resetting of LDAP Password Process Initiated================="
          puts "============username==========>#{username}========================="
          ldap_reset_password = LDAP.new.change_password(username, decrypt_old_password(old_password), generated_password)
          update_column(:should_reset_password, "N")
        rescue LdapFault, Psych::SyntaxError, SystemCallError, Net::LDAP::LdapError => error
          puts "================Reset Password Error code: #{error}================"
          puts "================Failure in LDAP Reset Password================"
          update_column(:was_user_added, "N")
        else
          puts "==================Success in LDAP Reset Password========================"
          @message = self.test_ldap_login
          puts "================LDAP Test Login message value when Reset Password in LDAP Completes========>#{@message}================"
          if @message == "Login Successfull"
            puts "========Password Reset Successfully and test login also check with new password=========="
            notify_customer('Password Generated') unless Rails.env.test?
            update_column(:was_user_added, 'Y')
          else
            puts "========Password Reset Failure and test login also check failure with new password=========="
            update_column(:was_user_added, 'N')
          end
          puts "===============Was User Added to LDAP: #{was_user_added}==================="
        ensure
          puts "================Reset Password Execution Completed================"
        end
      end
    end
    
    if self.last_action == 'C' && self.approval_status == 'A' && self.lock_version >= 0
      puts "================IamCustUser ID: #{self.id}================"
      puts "================Fresh user addding block start================"
      LDAP.new.add_user(username, generated_password) rescue nil
      @max_retries = 2
      begin
        puts "================Connection To LDAP Initiated================="
        connect_to_ldap = LDAP.new.try_login(username, decrypted_password)
      rescue LdapFault, Psych::SyntaxError, SystemCallError, Net::LDAP::LdapError => error
        @retries ||= 0
        if @retries < @max_retries
          @retries += 1
          puts "================Retrying Connection: #{@retries}================"
          puts "Error code: #{error}"
          retry
        end
          puts "================Failure in LDAP Connection================"
        else
          group_check = LDAP.new.group_registration_check(username) rescue nil
          puts "==============Group Check Value Inside Fresh user addding block in Else condition=======#{group_check}================"
          if (group_check.present? && group_check.include?(true))
            puts "=================Inside Sending Notification block when Group Check Succeded============"
            puts"=================Group Check value Inside Notification block when Group Check Succeded========#{group_check}==============="
            update_column(:was_user_added, 'Y')
            notify_customer('Password Generated') unless Rails.env.test?
          else
            update_column(:was_user_added, 'N')
            puts"=================Group Check value Inside Notification block when Group Check has Failed========#{group_check}==============="
            puts "=================Notification not sent since Group Check has Failed==================="
          end
          puts "================Fresh user successlly added================"
          puts "================LDAP Connection Successful================"
        ensure
          puts "================Execution Completed================"
        end
      end
  end


  def delete_user_from_ldap_on_approval
    puts "================delete_user_from_ldap_on_approval method start for username: #{username}================"
    if approval_status == 'A' && (was_user_added == 'N' || was_user_added == nil)
      begin
        puts "================Deleting of LDAP User Process Initiated================="
        puts "============username==========>#{username}========================="
        LDAP.new.delete_user(username)
      rescue LdapFault, Psych::SyntaxError, SystemCallError, Net::LDAP::LdapError => error
        puts "================Delete User Error code: #{error}================"
        puts "================Failure in LDAP Delete User================"
      else
        puts "==================Success in LDAP Deleting user from LDAP========================"
        update_column(:was_user_added, 'N')
        notify_customer('Access Removed') unless Rails.env.test?
        puts "===============Was User Added to LDAP: #{was_user_added}==================="
      ensure
        puts "================Delete User Execution Completed================"
      end
    end
  end


  #Notification via sms/email is triggered
  def notify_customer(event)
    puts "========================notify_customer block start============================="
    begin
      puts "=============================================Notify Customer for username: #{username}============================================"
      if self.send_password_via == "sms"
        return sms_email_notifier("sms",event)
      elsif self.send_password_via == "email"
        return sms_email_notifier("email",event)
      elsif self.send_password_via == "both"
        return sms_email_notifier("both",event)
      elsif (self.send_password_via == "" || self.send_password_via == nil)
        return "Password Can't be Resend since Send Password Via value is blank, so kindly update the value first!"
      end
    rescue Exception => e
      puts "===========Error occurred while Sending Notification for username: #{username}============"
      return "Error occured => #{e}"
    end
  end

  def sms_email_notifier(state,event)
    event_id = ScEvent.find_by_event(event).try(:id)
    template = NsTemplate.find_by_sc_event_id_and_is_enabled(event_id,'Y') rescue nil
    unless template.nil?
      if state == "sms"
        plsql.pk_qg_send_sms.enqueue(ENV['CONFIG_IIB_SMTP_BROKER_UUID'], self.mobile_no, NsTemplate.render_template(template.sms_text, template_variables(event))) unless template.sms_text.to_s.empty?
        plsql.pk_qg_send_sms.enqueue(ENV['CONFIG_IIB_SMTP_BROKER_UUID'], self.secondary_mobile_no, NsTemplate.render_template(template.sms_text1, template_variables(event))) unless template.sms_text1.to_s.empty?
        update_column(:notification_sent_at, Time.zone.now)
        return true
      elsif state == "email"
        plsql.pk_qg_send_email.enqueue1(ENV['CONFIG_IIB_SMTP_BROKER_UUID'], self.email, NsTemplate.render_template(template.email_subject, template_variables(event)), NsTemplate.render_template(template.email_body, template_variables(event))) unless template.email_body.to_s.empty?
        plsql.pk_qg_send_email.enqueue1(ENV['CONFIG_IIB_SMTP_BROKER_UUID'], self.secondary_email, NsTemplate.render_template(template.email_subject, template_variables(event)), NsTemplate.render_template(template.email_body1, template_variables(event))) unless template.email_body1.to_s.empty?
        update_column(:notification_sent_at, Time.zone.now)
        return true
      elsif state == "both"
        plsql.pk_qg_send_sms.enqueue(ENV['CONFIG_IIB_SMTP_BROKER_UUID'], self.mobile_no, NsTemplate.render_template(template.sms_text, template_variables(event))) unless template.sms_text.to_s.empty?
        plsql.pk_qg_send_email.enqueue1(ENV['CONFIG_IIB_SMTP_BROKER_UUID'], self.email, NsTemplate.render_template(template.email_subject, template_variables(event)), NsTemplate.render_template(template.email_body1, template_variables(event))) unless template.email_body1.to_s.empty?
        update_column(:notification_sent_at, Time.zone.now)
        return true
      end
    else
      puts "===========Template is nil so notification not sent============="
      'Template is not setup for SMS / Email'
    end
  end

  def enable_resend_button?
    approval_status == 'A' ? true: false
  end
end