# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_07_133359) do
  create_table "admin_roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id", precision: 38
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_admin_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_admin_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_admin_roles_on_resource"
  end

  create_table "admin_users_admin_roles", id: false, force: :cascade do |t|
    t.integer "admin_user_id", precision: 38
    t.integer "admin_role_id", precision: 38
    t.index ["admin_role_id"], name: "index_admin_users_admin_roles_on_admin_role_id"
    t.index ["admin_user_id", "admin_role_id"], name: "index_on_user_roles"
    t.index ["admin_user_id"], name: "index_admin_users_admin_roles_on_admin_user_id"
  end

  create_table "banks", force: :cascade do |t|
    t.string "ifsc"
    t.string "name"
    t.boolean "imps_enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "created_by"
    t.string "updated_by"
    t.integer "lock_version", precision: 38, default: 0, null: false
    t.string "approval_status", limit: 1, default: "U", null: false
    t.string "last_action", limit: 1, default: "C"
    t.integer "approved_version", precision: 38
    t.integer "approved_id", precision: 38
    t.index ["ifsc", "approval_status"], name: "index_banks_on_ifsc_and_approval_status", unique: true
  end

  create_table "bm_rules", force: :cascade do |t|
    t.string "cod_acct_no", limit: 16, null: false, comment: "the pool account assigned to the aggregator, the balance is owed to the aggregator"
    t.string "customer_id", limit: 15, null: false, comment: "the customer-id that owns the pool account"
    t.string "bene_acct_no", null: false, comment: "the aggregators account no, funds are remitted to this account"
    t.string "bene_account_ifsc", null: false, comment: "the IFSC code of the bank that holds the aggregators account."
    t.string "neft_sender_ifsc", null: false, comment: "the IFSC code of your bank, that should be used while remitting funds to the aggregator"
    t.integer "lock_version", precision: 38, null: false, comment: "the version number of the record, every update increments this by 1."
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.datetime "updated_at", null: false, comment: "the timestamp when the record was last updated"
    t.string "approval_status", default: "U", null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
    t.string "last_action", default: "C", comment: "the last action (create, update) that was performed on the record."
    t.integer "approved_version", precision: 38, comment: "the version number of the record, at the time it was approved"
    t.integer "approved_id", precision: 38, comment: "the id of the record that is being updated"
    t.string "created_by", limit: 20, comment: "the user who created the record"
    t.string "updated_by", limit: 20, comment: "the user who updated the record"
    t.string "source_id", limit: 50, default: "qg", null: false, comment: "the identifier provided by the aggregator to the bank for identification"
    t.integer "traceid_prefix", precision: 38, default: 1, null: false, comment: "for generating unique requestNo for calling billdesk"
    t.string "service_id"
  end

  create_table "countries", primary_key: "country_id", id: { type: :string, limit: 2, comment: "Primary key of countries table." }, comment: "country table. Contains 25 rows. References with locations table.", force: :cascade do |t|
    t.string "country_name", limit: 40, comment: "Country name"
    t.decimal "region_id", comment: "Region ID for the country. Foreign key to region_id column in the departments table."
  end

  create_table "departments", primary_key: "department_id", id: { limit: 4, precision: 4, comment: "Primary key column of departments table." }, comment: "Departments table that shows details of departments where employees\nwork. Contains 27 rows; references with locations, employees, and job_history tables.", force: :cascade do |t|
    t.string "department_name", limit: 30, null: false, comment: "A not null column that shows name of a department. Administration,\nMarketing, Purchasing, Human Resources, Shipping, IT, Executive, Public\nRelations, Sales, Finance, and Accounting. "
    t.integer "manager_id", limit: 6, precision: 6, comment: "Manager_id of a department. Foreign key to employee_id column of employees table. The manager_id column of the employee table references this column."
    t.integer "location_id", limit: 4, precision: 4, comment: "Location id where a department is located. Foreign key to location_id column of locations table."
    t.index ["location_id"], name: "dept_location_ix"
  end

  create_table "ecol_rules", force: :cascade do |t|
    t.string "ifsc", limit: 11, null: false
    t.string "cod_acct_no", limit: 15, null: false
    t.string "stl_gl_inward", limit: 15, null: false
    t.string "created_by", limit: 20
    t.string "updated_by", limit: 20
    t.string "lock_version", default: "0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "approval_status", limit: 1, default: "U"
    t.string "last_action", limit: 1, default: "C"
    t.integer "approved_version", precision: 38
    t.integer "approved_id", precision: 38
    t.string "neft_sender_ifsc", null: false
    t.string "customer_id", null: false
    t.string "return_account_no", limit: 20, comment: "the common return account for imps, since remitter detail is not present in the incoming credit"
  end

  create_table "employees", primary_key: "employee_id", id: { limit: 6, precision: 6, comment: "Primary key of employees table." }, comment: "employees table. Contains 107 rows. References with departments,\njobs, job_history tables. Contains a self reference.", force: :cascade do |t|
    t.string "first_name", limit: 20, comment: "First name of the employee. A not null column."
    t.string "last_name", limit: 25, null: false, comment: "Last name of the employee. A not null column."
    t.string "email", limit: 25, null: false, comment: "Email id of the employee"
    t.string "phone_number", limit: 20, comment: "Phone number of the employee; includes country code and area code"
    t.date "hire_date", null: false, comment: "Date when the employee started on this job. A not null column."
    t.string "job_id", limit: 10, null: false, comment: "Current job of the employee; foreign key to job_id column of the\njobs table. A not null column."
    t.decimal "salary", precision: 8, scale: 2, comment: "Monthly salary of the employee. Must be greater\nthan zero (enforced by constraint emp_salary_min)"
    t.decimal "commission_pct", precision: 2, scale: 2, comment: "Commission percentage of the employee; Only employees in sales\ndepartment elgible for commission percentage"
    t.integer "manager_id", limit: 6, precision: 6, comment: "Manager id of the employee; has same domain as manager_id in\ndepartments table. Foreign key to employee_id column of employees table.\n(useful for reflexive joins and CONNECT BY query)"
    t.integer "department_id", limit: 4, precision: 4, comment: "Department id where employee works; foreign key to department_id\ncolumn of the departments table"
    t.index ["department_id"], name: "emp_department_ix"
    t.index ["email"], name: "emp_email_uk", unique: true
    t.index ["job_id"], name: "emp_job_ix"
    t.index ["last_name", "first_name"], name: "emp_name_ix"
    t.index ["manager_id"], name: "emp_manager_ix"
  end

  create_table "fp_auth_rules", force: :cascade do |t|
    t.string "username", null: false, comment: "the identity that is allowed access to the operation"
    t.string "operation_name", limit: 4000, null: false, comment: "the operation to which access is granted"
    t.string "is_enabled", limit: 1, default: "N", null: false, comment: "the indicator to denote whether the access is enabled"
    t.integer "lock_version", precision: 38, null: false
    t.string "approval_status", limit: 1, default: "U", null: false
    t.string "last_action", limit: 1
    t.integer "approved_version", precision: 38
    t.integer "approved_id", precision: 38
    t.string "created_by", limit: 20
    t.string "updated_by", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "source_ips", limit: 4000, comment: "the list of ip-address(s) from which connections are accepted for the user"
    t.string "any_source_ip", limit: 1, default: "N", null: false, comment: "this field indicates whether any ip address is acceptable or not"
    t.index ["username", "approval_status"], name: "uk_fp_auth_rules", unique: true
  end

  create_table "ft_customers", force: :cascade do |t|
    t.string "app_id", limit: 20, null: false, comment: "the unique id assigned to a client app"
    t.string "name", limit: 100, null: false, comment: "the name of the customers"
    t.integer "low_balance_alert_at", precision: 38, null: false, comment: "the amount for low balance alert"
    t.string "identity_user_id", null: false, comment: "the user ID of Customer"
    t.string "allow_neft", limit: 1, null: false, comment: "the flag to indicate if NEFT is allowed for this customer"
    t.string "allow_imps", limit: 1, null: false, comment: "the flag to indicate if IMPS is allowed for this customer"
    t.string "allow_rtgs", limit: 1, comment: "the flag to identify whether rtgs is allowed for the app_id or not"
    t.string "string", limit: 1, comment: "the flag to identify whether rtgs is allowed for the app_id or not"
    t.string "enabled", limit: 1, default: "N", null: false, comment: "the flag to indicate if customer is enabled"
    t.string "is_retail", limit: 1, comment: "the flag to identify whether app_id is for retail or corporate customer"
    t.string "created_by", limit: 20, comment: "the person who creates the record"
    t.string "updated_by", limit: 20, comment: "the person who updates the record"
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.datetime "updated_at", null: false, comment: "the timestamp when the record was last updated"
    t.integer "lock_version", precision: 38, default: 0, null: false, comment: "the version number of the record, every update increments this by 1"
    t.string "approval_status", limit: 1, default: "U", null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
    t.string "last_action", limit: 1, default: "C", null: false, comment: "the last action (create, update) that was performed on the record"
    t.integer "approved_version", precision: 38, comment: "the version number of the record, at the time it was approved"
    t.integer "approved_id", precision: 38, comment: "the id of the record that is being updated"
    t.string "needs_purpose_code", limit: 1, comment: "the flag which indicates whether the purpose_code is mandatory for this customer"
    t.string "reply_with_bene_name", limit: 1, default: "N", comment: "the flag which indicates whether the bene name returned by the bene bank should be returned in the transferResponse or not"
    t.string "allow_all_accounts", limit: 1, default: "Y", null: false, comment: "the flag to allow all accounts or restrict to a specified set in ft_cust_accounts"
    t.index ["name"], name: "in_ft_customers_1"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "imt_add_beneficiaries", force: :cascade do |t|
    t.string "req_no", null: false, comment: "the unique reference number to be sent by the client application"
    t.integer "attempt_no", precision: 38, null: false, comment: "the attempt number of the request, failed requests can be retried"
    t.string "status_code", limit: 25, null: false, comment: "the status of this request"
    t.string "req_version", limit: 10, null: false, comment: "the service version number received in the request"
    t.datetime "req_timestamp", null: false, comment: "the SYSDATE when the request was sent to the service provider"
    t.string "app_id", limit: 50, null: false, comment: "the identifier for the client"
    t.string "customer_id", limit: 50, null: false, comment: "the unique no of the customer"
    t.string "bene_mobile_no", limit: 50, null: false, comment: "the mobile no of the beneficiary"
    t.string "bene_name", limit: 50, null: false, comment: "the name of the beneficiary"
    t.string "bene_address_line", null: false, comment: "the address of the beneficiary"
    t.string "bene_city", null: false, comment: "the city name of the beneficiary"
    t.string "bene_postal_code", null: false, comment: "the postal code of the beneficiary"
    t.string "rep_no", comment: "the unique response number sent back by the API"
    t.string "rep_version", limit: 10, comment: "the service version sent in the reply"
    t.datetime "rep_timestamp", comment: "the SYSDATE when the reply was sent to the client"
    t.string "fault_code", limit: 50, comment: "the code that identifies the business failure reason/exception"
    t.string "fault_reason", limit: 1000, comment: "the english reason of the business failure reason/exception"
    t.string "fault_subcode", limit: 50, comment: "the error code that the third party will return"
    t.index ["req_no", "app_id", "attempt_no"], name: "uk_imt_add_bene", unique: true
  end

  create_table "imt_audit_logs", force: :cascade do |t|
    t.string "req_no", limit: 32, null: false, comment: "the unique request number sent by the client"
    t.string "app_id", limit: 32, null: false, comment: "the identifier for the client"
    t.integer "attempt_no", precision: 38, null: false, comment: "the attempt number of the request, failed requests can be retried"
    t.string "status_code", limit: 25, null: false, comment: "the status of this request"
    t.string "imt_auditable_type", null: false, comment: "the name of the table that represents the request that is related to this record"
    t.integer "imt_auditable_id", precision: 38, null: false, comment: "the id of the row that represents the request that is related to this recrod"
    t.string "fault_code", comment: "the code that identifies the exception, if an exception occured in the ESB"
    t.string "fault_reason", limit: 1000, comment: "the english reason of the exception, if an exception occurred in the ESB"
    t.datetime "req_timestamp", comment: "the SYSDATE when the request was received from the client"
    t.datetime "rep_timestamp", comment: "the SYSDATE when the reply was sent to the client"
    t.text "req_bitstream", null: false, comment: "the full request payload as received from the client"
    t.text "rep_bitstream", comment: "the full reply payload as sent to the client"
    t.text "fault_bitstream", comment: "the complete exception list/stack trace of an exception that occured in the ESB"
    t.string "fault_subcode", limit: 50, comment: "the error code that the third party will return"
    t.index ["app_id", "req_no", "attempt_no"], name: "uk_imt_audit_logs_1", unique: true
    t.index ["imt_auditable_type", "imt_auditable_id"], name: "uk_imt_audit_logs_2", unique: true
  end

  create_table "imt_audit_steps", force: :cascade do |t|
    t.string "imt_auditable_type", null: false, comment: "the name of the table that represents the request that is related to this record"
    t.integer "imt_auditable_id", precision: 38, null: false, comment: "the id of the row that represents the request that is related to this recrod"
    t.integer "step_no", precision: 38, null: false, comment: "the step of the transaction, for which this record exists"
    t.integer "attempt_no", precision: 38, null: false, comment: "the attempt number of the request, failed requests can be retried"
    t.string "step_name", limit: 100, null: false, comment: "the english name of the step: create user, request token, access token, modify user, add address, add card, activate card"
    t.string "status_code", limit: 25, null: false, comment: "the status of this attempt of the step"
    t.string "fault_code", comment: "the code that identifies the exception, if an exception occured in the ESB"
    t.string "fault_reason", limit: 1000, comment: "the english reason of the exception, if an exception occurred in the ESB"
    t.string "req_reference", comment: "the reference number that was sent to the service provider"
    t.datetime "req_timestamp", comment: "the SYSDATE when the request was sent to the service provider"
    t.string "rep_reference", comment: "the reference number as received from ther service provider"
    t.datetime "rep_timestamp", comment: "the SYSDATE when the reply was sent to the client"
    t.text "req_bitstream", comment: "the full request payload as received from the client"
    t.text "rep_bitstream", comment: "the full reply payload as sent to the client"
    t.text "fault_bitstream", comment: "the complete exception list/stack trace of an exception that occured in the ESB"
    t.string "fault_subcode", limit: 50, comment: "the error code that the third party will return"
    t.datetime "reconciled_at", comment: "the SYSDATE when the transaction was reconciled"
    t.index ["imt_auditable_type", "imt_auditable_id", "step_no", "attempt_no"], name: "uk_imt_audit_steps", unique: true
  end

  create_table "imt_cancel_transfers", force: :cascade do |t|
    t.string "req_no", null: false, comment: "the unique reference number to be sent by the client application"
    t.integer "attempt_no", precision: 38, null: false, comment: "the attempt number of the request, failed requests can be retried"
    t.string "status_code", limit: 25, null: false, comment: "the status of this request"
    t.string "req_version", limit: 10, null: false, comment: "the service version number received in the request"
    t.datetime "req_timestamp", null: false, comment: "the SYSDATE when the request was sent to the service provider"
    t.string "app_id", limit: 50, null: false, comment: "the identifier for the client"
    t.string "customer_id", limit: 50, null: false, comment: "the unique no of the customer"
    t.string "req_ref_no", limit: 50, null: false, comment: "the uniqueRequestNo of an earlier completed transfer transaction, that needs to be cancelled"
    t.string "cancel_reason", limit: 50, null: false, comment: "the reason to cancel the transfer. This is for reporting/MIS, it is not sent to the beneficiary"
    t.string "rep_no", comment: "the unique response number sent back by the API"
    t.string "rep_version", limit: 10, comment: "the service version sent in the reply"
    t.datetime "rep_timestamp", comment: "the SYSDATE when the reply was sent to the client"
    t.string "imt_ref_no", comment: "the reference number generated by IMT"
    t.string "bank_ref_no", comment: "the reference number generated by the bank, and passed on to the payment network"
    t.string "fault_code", limit: 50, comment: "the code that identifies the business failure reason/exception"
    t.string "fault_reason", limit: 1000, comment: "the english reason of the business failure reason/exception"
    t.string "fault_subcode", limit: 50, comment: "the error code that the third party will return"
    t.string "pending_approval", limit: 1, default: "Y", comment: "the flag which indicates whether the transaction is approved or not"
    t.index ["bank_ref_no"], name: "index_imt_cancel_transfers_on_bank_ref_no", unique: true
    t.index ["req_no", "app_id", "attempt_no"], name: "uk_imt_cancel_trans", unique: true
  end

  create_table "imt_customers", force: :cascade do |t|
    t.string "customer_code", null: false, comment: "the unique no of the customer"
    t.string "customer_name", null: false, comment: "the name of the customer"
    t.string "contact_person", null: false, comment: "the name of the contact person"
    t.string "email_id", null: false, comment: "the email id of the customer"
    t.string "is_enabled", limit: 1, null: false, comment: "the indicator to denote if the customer is allowed access"
    t.string "mobile_no", null: false, comment: "the mobile no of the customer"
    t.string "account_no", null: false, comment: "the account no of the customer"
    t.integer "expiry_period", precision: 38, null: false, comment: "the number of the day in which IMT will expire"
    t.string "txn_mode", limit: 4, null: false, comment: "the indicator to identify whether the transaction will be processed through Api or File Upload"
    t.string "address_line1", comment: "the address line1 of the customer"
    t.string "address_line2", comment: "the address line2 of the customer"
    t.string "address_line3", comment: "the address line3 of the customer"
    t.string "country", comment: "the country of the customer"
    t.integer "lock_version", precision: 38, null: false
    t.string "approval_status", limit: 1, default: "U", null: false
    t.string "last_action", limit: 1
    t.integer "approved_version", precision: 38
    t.integer "approved_id", precision: 38
    t.string "created_by", limit: 20
    t.string "updated_by", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "app_id", null: false, comment: "the identifier for the client"
    t.string "identity_user_id", limit: 20, null: false, comment: "the identity of the user"
    t.index ["account_no"], name: "index_imt_customers_on_account_no"
    t.index ["app_id", "approval_status"], name: "uk1_imt_customers", unique: true
    t.index ["customer_code"], name: "index_imt_customers_on_customer_code"
    t.index ["customer_name"], name: "index_imt_customers_on_customer_name"
  end

  create_table "imt_del_beneficiaries", force: :cascade do |t|
    t.string "req_no", null: false, comment: "the unique reference number to be sent by the client application"
    t.integer "attempt_no", precision: 38, null: false, comment: "the attempt number of the request, failed requests can be retried"
    t.string "status_code", limit: 25, null: false, comment: "the status of this request"
    t.string "req_version", limit: 10, null: false, comment: "the service version number received in the request"
    t.datetime "req_timestamp", null: false, comment: "the SYSDATE when the request was sent to the service provider"
    t.string "app_id", limit: 50, null: false, comment: "the identifier for the client"
    t.string "customer_id", limit: 50, null: false, comment: "the unique no of the customer"
    t.string "bene_mobile_no", limit: 50, null: false, comment: "the mobile no of the beneficiary"
    t.string "rep_no", comment: "the unique response number sent back by the API"
    t.string "rep_version", limit: 10, comment: "the service version sent in the reply"
    t.datetime "rep_timestamp", comment: "the SYSDATE when the reply was sent to the client"
    t.string "fault_code", limit: 50, comment: "the code that identifies the business failure reason/exception"
    t.string "fault_reason", limit: 1000, comment: "the english reason of the business failure reason/exception"
    t.string "fault_subcode", limit: 50, comment: "the error code that the third party will return"
    t.index ["req_no", "app_id", "attempt_no"], name: "uk_imt_del_bene", unique: true
  end

  create_table "imt_initiate_transfers", force: :cascade do |t|
    t.string "req_no", null: false, comment: "the unique reference number to be sent by the client application"
    t.integer "attempt_no", precision: 38, null: false, comment: "the attempt number of the request, failed requests can be retried"
    t.string "status_code", limit: 25, null: false, comment: "the status of this request"
    t.string "req_version", limit: 10, null: false, comment: "the service version number received in the request"
    t.datetime "req_timestamp", null: false, comment: "the SYSDATE when the request was sent to the service provider"
    t.string "app_id", limit: 50, null: false, comment: "the identifier for the client"
    t.string "customer_id", limit: 50, null: false, comment: "the unique no of the customer"
    t.string "bene_mobile_no", limit: 50, null: false, comment: "the mobile no of the beneficiary"
    t.string "pass_code", limit: 5, null: false, comment: "the passcode, this is shared with the beneficiary, and is needed for funds withdrawal from the ATM"
    t.string "rmtr_to_bene_note", null: false, comment: "the friendly note from the remitter to the beneficiary"
    t.date "expiry_date", comment: "the expiry date, computed for this transfer"
    t.string "rep_no", comment: "the unique response number sent back by the API"
    t.string "rep_version", limit: 10, comment: "the service version sent in the reply"
    t.datetime "rep_timestamp", comment: "the SYSDATE when the reply was sent to the client"
    t.string "imt_ref_no", comment: "the reference number generated by IMT"
    t.string "bank_ref_no", comment: "the reference number generated by the bank, and passed on to the payment network"
    t.string "fault_code", limit: 50, comment: "the code that identifies the business failure reason/exception"
    t.string "fault_reason", limit: 1000, comment: "the english reason of the business failure reason/exception"
    t.string "fault_subcode", limit: 50, comment: "the error code that the third party will return"
    t.string "pending_approval", limit: 1, default: "Y", comment: "the flag which indicates whether the transaction is approved or not"
    t.index ["bank_ref_no"], name: "index_imt_initiate_transfers_on_bank_ref_no", unique: true
    t.index ["req_no", "app_id", "attempt_no"], name: "uk_imt_tranfers", unique: true
  end

  create_table "imt_pending_steps", force: :cascade do |t|
    t.string "broker_uuid", null: false
    t.datetime "created_at", null: false
    t.integer "imt_audit_step_id", precision: 38, default: 1, null: false
  end

  create_table "imt_transfers", force: :cascade do |t|
    t.string "imt_ref_no", limit: 35, comment: "the reference number generated by IMT"
    t.string "status_code", limit: 25, null: false, comment: "the status of the transfer"
    t.string "customer_id", limit: 50, null: false, comment: "the unique no of the customer"
    t.string "bene_mobile_no", limit: 50, null: false, comment: "the mobile no of the beneficiary"
    t.string "rmtr_to_bene_note", null: false, comment: "the friendly note from the remitter to the beneficiary"
    t.date "expiry_date", comment: "the expiry date, computed for this transfer"
    t.datetime "initiated_at", comment: "the date on which the transfer was initiated"
    t.string "initiation_ref_no", limit: 64, null: false, comment: "the unique reference no of the initiate_transfer operation"
    t.datetime "completed_at", comment: "the date on which the transfer was completed"
    t.string "acquiring_bank", comment: "the bank at which the transfer was completed"
    t.datetime "cancelled_at", comment: "the date on which the transfer was cancelled"
    t.string "cancellation_ref_no", limit: 64, comment: "the unique reference no of the cancel_transfer operation"
    t.datetime "expired_at", comment: "the date on which the transfer expired, this is updated only on confirmation of the expiry from IMT"
    t.string "cancel_reason", comment: "the reason to cancel the transfer"
    t.string "initiation_bank_ref", null: false, comment: "the unique ref no that was generated and sent to empays (imt) during initiate_transfer"
    t.string "cancellation_bank_ref", comment: "the unique ref no that was generated and sent to empays (imt) during cancel_transfer"
    t.index ["cancellation_ref_no"], name: "uk_imt_transfers_3", unique: true
    t.index ["imt_ref_no"], name: "uk_imt_transfers_1", unique: true
    t.index ["initiation_ref_no"], name: "uk_imt_transfers_2", unique: true
  end

  create_table "imt_unapproved_records", force: :cascade do |t|
    t.integer "imt_approvable_id", precision: 38
    t.string "imt_approvable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inw_remittance_rules", force: :cascade do |t|
    t.string "pattern_individuals", limit: 4000
    t.string "pattern_corporates", limit: 4000
    t.string "pattern_beneficiaries", limit: 4000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "created_by"
    t.string "updated_by"
    t.integer "lock_version", precision: 38, default: 0, null: false
    t.string "pattern_salutations", limit: 2000
    t.string "approval_status", limit: 1, default: "U", null: false
    t.string "last_action", limit: 1, default: "C"
    t.integer "approved_version", precision: 38
    t.integer "approved_id", precision: 38
  end

  create_table "inward_remittances_locks", id: false, force: :cascade do |t|
    t.integer "inward_remittance_id", precision: 38
    t.string "created_at"
  end

  create_table "job_history", primary_key: ["employee_id", "start_date"], comment: "Table that stores job history of the employees. If an employee\nchanges departments within the job or changes jobs within the department,\nnew rows get inserted into this table with old job information of the\nemployee. Contains a complex primary key: employee_id+start_date.\nContains 25 rows. References with jobs, employees, and departments tables.", force: :cascade do |t|
    t.integer "employee_id", limit: 6, precision: 6, null: false, comment: "A not null column in the complex primary key employee_id+start_date.\nForeign key to employee_id column of the employee table"
    t.date "start_date", null: false, comment: "A not null column in the complex primary key employee_id+start_date.\nMust be less than the end_date of the job_history table. (enforced by\nconstraint jhist_date_interval)"
    t.date "end_date", null: false, comment: "Last day of the employee in this job role. A not null column. Must be\ngreater than the start_date of the job_history table.\n(enforced by constraint jhist_date_interval)"
    t.string "job_id", limit: 10, null: false, comment: "Job role in which the employee worked in the past; foreign key to\njob_id column in the jobs table. A not null column."
    t.integer "department_id", limit: 4, precision: 4, comment: "Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table"
    t.index ["department_id"], name: "jhist_department_ix"
    t.index ["employee_id"], name: "jhist_employee_ix"
    t.index ["job_id"], name: "jhist_job_ix"
  end

  create_table "jobs", primary_key: "job_id", id: { type: :string, limit: 10, comment: "Primary key of jobs table." }, comment: "jobs table with job titles and salary ranges. Contains 19 rows.\nReferences with employees and job_history table.", force: :cascade do |t|
    t.string "job_title", limit: 35, null: false, comment: "A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT"
    t.integer "min_salary", limit: 6, precision: 6, comment: "Minimum salary for a job title."
    t.integer "max_salary", limit: 6, precision: 6, comment: "Maximum salary for a job title"
  end

  create_table "locations", primary_key: "location_id", id: { limit: 4, precision: 4, comment: "Primary key of locations table" }, comment: "Locations table that contains specific address of a specific office,\nwarehouse, and/or production site of a company. Does not store addresses /\nlocations of customers. Contains 23 rows; references with the\ndepartments and countries tables. ", force: :cascade do |t|
    t.string "street_address", limit: 40, comment: "Street address of an office, warehouse, or production site of a company.\nContains building number and street name"
    t.string "postal_code", limit: 12, comment: "Postal code of the location of an office, warehouse, or production site\nof a company. "
    t.string "city", limit: 30, null: false, comment: "A not null column that shows city where an office, warehouse, or\nproduction site of a company is located. "
    t.string "state_province", limit: 25, comment: "State or Province where an office, warehouse, or production site of a\ncompany is located."
    t.string "country_id", limit: 2, comment: "Country where an office, warehouse, or production site of a company is\nlocated. Foreign key to country_id column of the countries table."
    t.index ["city"], name: "loc_city_ix"
    t.index ["country_id"], name: "loc_country_ix"
    t.index ["state_province"], name: "loc_state_province_ix"
  end

  create_table "pc_fee_rules", force: :cascade do |t|
    t.string "app_id", limit: 50, null: false, comment: "the unique id assigned to the client app"
    t.string "txn_kind", limit: 50, null: false, comment: "the transaction for which the fee rules are configured"
    t.integer "no_of_tiers", precision: 38, null: false, comment: "the no of tiers (max 3)"
    t.integer "tier1_to_amt", precision: 38, null: false, comment: "the to amount (exclusive) for tier 1"
    t.string "tier1_method", limit: 3, null: false, comment: "the fee computation method (Fixed/Percentage) for tier 1"
    t.integer "tier1_fixed_amt", precision: 38, null: false, comment: "the fixed fee amount for tier 1"
    t.integer "tier1_pct_value", precision: 38, null: false, comment: "the pct value for tier 1"
    t.integer "tier1_min_sc_amt", precision: 38, null: false, comment: "the min fee amount, when pct is applied for tier 1"
    t.integer "tier1_max_sc_amt", precision: 38, null: false, comment: "the max fee amount, when pct is applied for tier 1"
    t.integer "tier2_to_amt", precision: 38, comment: "the to amount (exclusive) for tier 2"
    t.string "tier2_method", limit: 3, comment: "the fee computation method (Fixed/Percentage) for tier 2"
    t.integer "tier2_fixed_amt", precision: 38, comment: "the fixed fee amount for tier 2"
    t.integer "tier2_pct_value", precision: 38, comment: "the pct value for tier 2"
    t.integer "tier2_min_sc_amt", precision: 38, comment: "the min fee amount, when pct is applied for tier 2"
    t.integer "tier2_max_sc_amt", precision: 38, comment: "the max fee amount, when pct is applied for tier 2"
    t.string "tier3_method", limit: 3, comment: "the fee computation method (Fixed/Percentage) for tier 3"
    t.integer "tier3_fixed_amt", precision: 38, comment: "the fixed fee amount for tier 3"
    t.integer "tier3_pct_value", precision: 38, comment: "the pct value for tier 3"
    t.integer "tier3_min_sc_amt", precision: 38, comment: "the min fee amount, when pct is applied for tier 3"
    t.integer "tier3_max_sc_amt", precision: 38, comment: "the max fee amount, when pct is applied for tier 3"
    t.integer "lock_version", precision: 38, null: false
    t.string "approval_status", limit: 1, default: "U", null: false
    t.string "last_action", limit: 1
    t.integer "approved_version", precision: 38
    t.integer "approved_id", precision: 38
    t.string "created_by", limit: 20
    t.string "updated_by", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id", "txn_kind", "approval_status"], name: "uk_pc_fee_rules", unique: true
  end

  create_table "pending_inward_remittances", force: :cascade do |t|
    t.integer "inward_remittance_id", limit: 30, precision: 30, null: false
    t.string "broker_uuid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inward_remittance_id"], name: "index_pending_inward_remittances_on_inward_remittance_id", unique: true
  end

  create_table "purpose_codes", force: :cascade do |t|
    t.string "code", limit: 4
    t.string "description"
    t.string "is_enabled", limit: 1
    t.string "created_by", limit: 20
    t.string "updated_by", limit: 20
    t.integer "lock_version", precision: 38
    t.decimal "txn_limit"
    t.integer "daily_txn_limit", precision: 38
    t.string "disallowed_rem_types", limit: 30
    t.string "disallowed_bene_types", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "mtd_txn_cnt_self"
    t.decimal "mtd_txn_limit_self"
    t.decimal "mtd_txn_cnt_sp"
    t.decimal "mtd_txn_limit_sp"
    t.string "rbi_code", limit: 5
    t.string "pattern_beneficiaries", limit: 4000
    t.string "approval_status", limit: 1, default: "U", null: false
    t.string "last_action", limit: 1, default: "C"
    t.integer "approved_version", precision: 38
    t.integer "approved_id", precision: 38
    t.string "pattern_allowed_benes", limit: 4000, comment: "the allowed names in beneficiaries"
  end

  create_table "regions", primary_key: "region_id", id: :decimal, force: :cascade do |t|
    t.string "region_name", limit: 25
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id", precision: 38
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "sm_bank_accounts", force: :cascade do |t|
    t.string "sm_code", limit: 20, null: false, comment: "the unique code assigned to the submember, this associates to sm_banks"
    t.string "customer_id", limit: 15, null: false, comment: "the customer id assigned to the smb, multiple ids can be assigned"
    t.string "account_no", limit: 20, null: false, comment: "the account no of the smb, the customer id specified should own this account"
    t.string "mmid", limit: 7, comment: "the mmid for the account, required for imps"
    t.string "mobile_no", limit: 10, comment: "the mobile no as registered with the mmid, required for imps"
    t.string "created_by", limit: 20, comment: "the person who creates the record"
    t.string "updated_by", limit: 20, comment: "the person who updates the record"
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.datetime "updated_at", null: false, comment: "the timestamp when the record was last updated"
    t.integer "lock_version", precision: 38, default: 0, null: false, comment: "the version number of the record, every update increments this by 1"
    t.string "approval_status", limit: 1, default: "U", null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
    t.string "last_action", limit: 1, default: "C", null: false, comment: "the last action (create, update) that was performed on the record"
    t.integer "approved_version", precision: 38, comment: "the version number of the record, at the time it was approved"
    t.integer "approved_id", precision: 38, comment: "the id of the record that is being updated"
    t.string "is_enabled", limit: 1, default: "Y", null: false, comment: "the flag to decide if the bank account is enabled or not"
    t.index ["account_no", "approval_status"], name: "sm_bank_accounts_02", unique: true
    t.index ["sm_code", "customer_id", "account_no", "approval_status"], name: "sm_bank_accounts_01", unique: true
  end

  create_table "sm_banks", force: :cascade do |t|
    t.string "code", limit: 20, null: false, comment: "the unique code assigned to the sub member"
    t.string "name", limit: 100, null: false, comment: "the name of the sub member"
    t.string "bank_code", limit: 20, null: false, comment: "the bank code of the sub member, all incoming requests are validated against this"
    t.string "identity_user_id", limit: 20, null: false, comment: "the minimum balance that the smb should maintain to avoid alerts"
    t.string "neft_allowed", limit: 1, null: false, comment: "the flag to indicate if NEFT is allowed"
    t.string "imps_allowed", limit: 1, null: false, comment: "the flag to indicate if IMPS is allowed"
    t.string "created_by", limit: 20, comment: "the person who creates the record"
    t.string "updated_by", limit: 20, comment: "the person who updates the record"
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.datetime "updated_at", null: false, comment: "the timestamp when the record was last updated"
    t.integer "lock_version", precision: 38, default: 0, null: false, comment: "the version number of the record, every update increments this by 1"
    t.string "approval_status", limit: 1, default: "U", null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
    t.string "last_action", limit: 1, default: "C", null: false, comment: "the last action (create, update) that was performed on the record"
    t.integer "approved_version", precision: 38, comment: "the version number of the record, at the time it was approved"
    t.integer "approved_id", precision: 38, comment: "the id of the record that is being updated"
    t.string "is_enabled", limit: 1, default: "Y", null: false, comment: "the flag to decide if the bank is enabled or not"
    t.index ["code", "approval_status"], name: "sm_banks_01", unique: true
    t.index ["name", "bank_code"], name: "sm_banks_02"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "approval_status", limit: 10
    t.decimal "lock_version"
    t.decimal "approved_id"
  end

  create_table "students123", force: :cascade do |t|
    t.string "name"
    t.string "approval_status"
    t.integer "lock_version", precision: 38
    t.integer "approved_id", precision: 38
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "unapproved_records", force: :cascade do |t|
    t.integer "approvable_id", precision: 38
    t.string "approvable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approvable_id", "approvable_type"], name: "uk_unapproved_records", unique: true
  end

  create_table "user_groups", force: :cascade do |t|
    t.integer "user_id", precision: 38
    t.integer "group_id", precision: 38
    t.integer "lock_version", precision: 38, default: 0, null: false
    t.string "approval_status", limit: 1, default: "U", null: false
    t.string "last_action", limit: 1, default: "C"
    t.integer "approved_version", precision: 38
    t.integer "approved_id", precision: 38
    t.string "created_by", limit: 20
    t.string "updated_by", limit: 20
    t.boolean "disabled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["group_id"], name: "index_user_groups_on_group_id"
    t.index ["user_id"], name: "index_user_groups_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id", precision: 38
    t.integer "role_id", precision: 38
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lock_version", precision: 38, default: 0, null: false
    t.string "approval_status", limit: 1, default: "U", null: false
    t.string "last_action", limit: 1, default: "C"
    t.integer "approved_version", precision: 38
    t.integer "approved_id", precision: 38
    t.string "created_by", limit: 20
    t.string "updated_by", limit: 20
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", precision: 38, default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.boolean "inactive", default: false
    t.string "last_name"
    t.integer "role_id", precision: 38
    t.string "current_sign_in_token"
    t.string "approval_status", limit: 10, default: "U"
    t.decimal "lock_version", null: false
    t.string "last_action", limit: 10
    t.decimal "approved_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "users_groups", id: false, force: :cascade do |t|
    t.integer "user_id", precision: 38
    t.integer "group_id", precision: 38
    t.index ["group_id"], name: "index_users_groups_on_group_id"
    t.index ["user_id"], name: "index_users_groups_on_user_id"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", precision: 38
    t.integer "role_id", precision: 38
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "whitelisted_identities", force: :cascade do |t|
    t.integer "partner_id", precision: 38, null: false
    t.string "full_name", limit: 50
    t.string "first_name", limit: 50
    t.string "last_name", limit: 50
    t.string "id_type", limit: 20
    t.string "id_number", limit: 50
    t.string "id_country"
    t.date "id_issue_date"
    t.date "id_expiry_date"
    t.string "is_verified", limit: 1
    t.date "verified_at"
    t.string "verified_by", limit: 20
    t.integer "first_used_with_txn_id", precision: 38
    t.integer "last_used_with_txn_id", precision: 38
    t.integer "times_used", precision: 38
    t.string "created_by", limit: 20
    t.string "updated_by", limit: 20
    t.integer "lock_version", precision: 38
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "approval_status", limit: 1, default: "U", null: false
    t.string "last_action", limit: 1, default: "C"
    t.integer "approved_version", precision: 38
    t.integer "approved_id", precision: 38
    t.index ["last_used_with_txn_id"], name: "index_whitelisted_identities_on_last_used_with_txn_id"
  end

  add_foreign_key "countries", "regions", primary_key: "region_id", name: "countr_reg_fk"
  add_foreign_key "departments", "employees", column: "manager_id", primary_key: "employee_id", name: "dept_mgr_fk"
  add_foreign_key "departments", "locations", primary_key: "location_id", name: "dept_loc_fk"
  add_foreign_key "employees", "departments", primary_key: "department_id", name: "emp_dept_fk"
  add_foreign_key "employees", "employees", column: "manager_id", primary_key: "employee_id", name: "emp_manager_fk"
  add_foreign_key "employees", "jobs", primary_key: "job_id", name: "emp_job_fk"
  add_foreign_key "job_history", "departments", primary_key: "department_id", name: "jhist_dept_fk"
  add_foreign_key "job_history", "employees", primary_key: "employee_id", name: "jhist_emp_fk"
  add_foreign_key "job_history", "jobs", primary_key: "job_id", name: "jhist_job_fk"
  add_foreign_key "locations", "countries", primary_key: "country_id", name: "loc_c_id_fk"
end
