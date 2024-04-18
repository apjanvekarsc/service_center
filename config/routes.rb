Rails.application.routes.draw do
   #get 'ft_customer_disable_lists/index'
  
  resources :ft_customer_disable_lists
  put '/ft_customer_disable_lists/:id/approve' => "ft_customer_disable_lists#approve"


  resources :encrypted_passwords

  devise_for :users, controllers: { sessions: 'sessions' }
  devise_for :admin_users, ActiveAdmin::Devise.config.merge(controllers: { sessions: 'admin/sessions', password_expired: 'password_expired' })
  
  resources :iam_audit_rules

  resources :unapproved_records

  resources :incoming_files do
    member do
      get 'download_file'
      get 'generate_response_file'
      get 'approve_restart'
      get 'skip_records'
      get 'reject'
      get 'process_file'
      get 'reset'
      get 'output_file'
      get 'ecol_process_file'
    end
    collection do
      get 'download_ecol_response_file'
    end
  end
  
  resources :incoming_file_records
  resources :pc_apps
  resources :pc_programs
  resources :pc_products
  resources :pc2_apps do
    member do
      put :resend_notification
    end
  end
  resources :pc2_cust_accounts
  resources :pc_unapproved_records
  resources :pc_fee_rules

  resources :csv_exports
  resources :reconciled_returns
  resources :su_customers
  resources :su_unapproved_records
  resources :su_incoming_records
  resources :ic_incoming_records
  resources :pc_mm_cd_incoming_records

  resources :cn_incoming_records do
    member do
      get 'download_file'
    end
  end
  resources :cnb2_incoming_records, except: :index do
    member do
      get 'download_file'
    end
    collection do
      get :index
      post :index
    end
  end
  resources :rr_incoming_records
  resources :outgoing_files do
    member do
      get 'download_response_file'
    end
  end

  resources :sm_banks do
    member do
      get :resend_notification
    end
  end

  resources :sm_bank_accounts
  resources :sm_unapproved_records

  resources :cn_unapproved_records
  resources :rr_unapproved_records
  
  resources :rc_transfer_schedules do 
    collection do
      get 'get_customer_name'
    end
  end

  resources :rc_transfers, except: :index do
    collection do
      put  'update_multiple'
      get :index
      put :index
    end
    member do
      put :retry
    end
  end
  resources :rc_apps
  resources :rc_transfer_unapproved_records

  resources :iam_cust_users, except: :index do
    collection do
      get :index
      get :index
      get :ldap_user_list
    end
    member do
      put :try_login
      post :add_user
      put :delete_user
      put :resend_password
    end
  end

  resources :iam_organisations, except: :index do
    collection do
      get :index
      put :index
    end
    member do
      put :resend_notification
    end
  end
  
  resources :iam_cust_users, except: :index do
    collection do
      get :index
      put :index
    end
    member do
      get :connect_to_ldap
    end
  end

  resources :fr_r01_incoming_records, except: :index do
    collection do
      get :index
      post :index
    end
  end

  resources :iam_audit_logs, only: [:index, :show] do 
    collection do
      get :index
      put :index
    end
  end

  get 'su_incoming_file_summary' => 'su_incoming_records#incoming_file_summary'
  get 'ic_incoming_file_summary' => 'ic_incoming_records#incoming_file_summary'
  get 'pc_mm_cd_incoming_file_summary' => 'pc_mm_cd_incoming_records#incoming_file_summary'
  get 'cn_incoming_file_summary' => 'cn_incoming_records#incoming_file_summary'
  get 'cnb2_incoming_file_summary' => 'cnb2_incoming_records#incoming_file_summary'
  get 'fr_r01_incoming_file_summary' => 'fr_r01_incoming_records#incoming_file_summary'
  get 'rr_incoming_file_summary' => 'rr_incoming_records#incoming_file_summary'
  get 'override_records' => 'incoming_files#override_records'
  get 'incoming_files/:id/audit_steps/:step_name' => 'incoming_files#audit_steps'
  get 'incoming_file_records/:id/audit_steps/:step_name' => 'incoming_file_records#audit_steps'
  get 'rc_transfers/:id/audit_steps/:step_name' => 'rc_transfers#audit_steps'
  get '/su_incoming_records/:id/audit_logs' => 'su_incoming_records#audit_logs'
  get '/ic_incoming_records/:id/audit_logs' => 'ic_incoming_records#audit_logs'
  get '/pc_mm_cd_incoming_records/:id/audit_logs' => 'pc_mm_cd_incoming_records#audit_logs'
  get '/cn_incoming_records/:id/audit_logs' => 'cn_incoming_records#audit_logs'
  get '/cnb2_incoming_records/:id/audit_logs' => 'cnb2_incoming_records#audit_logs'
  get '/fr_r01_incoming_records/:id/audit_logs' => 'fr_r01_incoming_records#audit_logs'
  get '/rr_incoming_records/:id/audit_logs' => 'rr_incoming_records#audit_logs'
  get '/iam_audit_rule/:id/audit_logs' => 'iam_audit_rules#audit_logs'
  get '/pc_app/:id/audit_logs' => 'pc_apps#audit_logs'
  get '/pc_program/:id/audit_logs' => 'pc_programs#audit_logs'
  get '/pc_product/:id/audit_logs' => 'pc_products#audit_logs'
  get '/pc2_app/:id/audit_logs' => 'pc2_apps#audit_logs'
  get '/pc2_cust_account/:id/audit_logs' => 'pc2_cust_accounts#audit_logs'
  get '/pc_fee_rule/:id/audit_logs' => 'pc_fee_rules#audit_logs'
  get '/reconciled_returns/:id/audit_logs' => 'reconciled_returns#audit_logs'
  get '/su_customers/:id/audit_logs' => 'su_customers#audit_logs'
  get '/ic_customers/:id/audit_logs' => 'ic_customers#audit_logs'
  get '/ic_suppliers/:id/audit_logs' => 'ic_suppliers#audit_logs'
  get '/sm_banks/:id/audit_logs' => 'sm_banks#audit_logs'
  get '/sm_bank_accounts/:id/audit_logs' => 'sm_bank_accounts#audit_logs'
  get '/rc_transfer_schedules/:id/audit_logs' => 'rc_transfer_schedules#audit_logs'

  put '/incoming_file/:id/approve' => "incoming_files#approve"
  
  put '/pc_app/:id/approve' => "pc_apps#approve"
  put '/pc_program/:id/approve' => "pc_programs#approve"
  put '/pc_product/:id/approve' => "pc_products#approve"
  put '/pc2_app/:id/approve' => "pc2_apps#approve"
  put '/pc2_cust_account/:id/approve' => "pc2_cust_accounts#approve"
  put '/pc_fee_rule/:id/approve' => "pc_fee_rules#approve"
  put '/su_customers/:id/approve' => "su_customers#approve"
  put '/ic_customers/:id/approve' => "ic_customers#approve"
  put '/ic_suppliers/:id/approve' => "ic_suppliers#approve"

  put '/sm_banks/:id/approve' => "sm_banks#approve"
  put '/sm_bank_accounts/:id/approve' => 'sm_bank_accounts#approve'
  put '/rc_transfer_schedules/:id/approve' => "rc_transfer_schedules#approve"

  get '/view_raw_content/:id' => "incoming_files#view_raw_content"
  
  get '/csv_export/download_csv' => 'csv_exports#download_csv'

  get '/pc_products/:id/encrypt_password' => 'pc_products#encrypt_password', as: :pc_products_encrypt_password
    
  get '/rc_apps/:id/audit_logs' => 'rc_apps#audit_logs'
  put '/rc_apps/:id/approve' => "rc_apps#approve"
  get '/rc_transfer_schedules/udfs/:rc_app_id' => 'rc_transfer_schedules#udfs'

  get '/iam_cust_users/:id/audit_logs' => 'iam_cust_users#audit_logs'
  put '/iam_cust_users/:id/approve' => "iam_cust_users#approve"
  get '/iam_organisations/:id/audit_logs' => 'iam_organisations#audit_logs'
  put '/iam_organisations/:id/approve' => "iam_organisations#approve"

  get 'imt_incoming_file_summary' => 'imt_incoming_records#incoming_file_summary'
  get '/imt_incoming_records/:id/audit_logs' => 'imt_incoming_records#audit_logs'
  
  get '/iam_cust_users/:id/audit_logs' => 'iam_cust_users#audit_logs'
  put '/iam_cust_users/:id/approve' => "iam_cust_users#approve"
  get '/iam_audit_rule_error_msg' => "iam_audit_rules#error_msg"
  
  get '/version' => 'dashboard#version'
  get '/env_config' => 'dashboard#env_config'
  get '/error_msg' => 'dashboard#error_msg'
  get 'dashboard/operations', as: :operations
  
  root :to => 'dashboard#overview'
  get '/get_group_long_form' => 'dashboard#get_group_long_form'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  ActiveAdmin.routes(self)
end
