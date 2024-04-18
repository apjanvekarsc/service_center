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

ActiveRecord::Schema[7.0].define(version: 2023_10_06_104225) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id", precision: 38
    t.string "author_type"
    t.integer "author_id", precision: 38
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

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

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.boolean "inactive", default: false
    t.string "current_sign_in_token"
    t.datetime "password_changed_at"
    t.string "unique_session_id"
    t.string "has_role"
    t.integer "sign_in_count", precision: 38
    t.string "current_sign_in_at"
    t.string "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "admin_user"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "admin_users_admin_roles", id: false, force: :cascade do |t|
    t.integer "admin_user_id", precision: 38
    t.integer "admin_role_id", precision: 38
    t.index ["admin_role_id"], name: "index_admin_users_admin_roles_on_admin_role_id"
    t.index ["admin_user_id", "admin_role_id"], name: "index_on_user_roles"
    t.index ["admin_user_id"], name: "index_admin_users_admin_roles_on_admin_user_id"
  end

  create_table "aq$_schedules", primary_key: ["oid", "destination"], force: :cascade do |t|
    t.raw "oid", limit: 16, null: false
    t.string "destination", limit: 390, null: false
    t.date "start_time"
    t.string "duration", limit: 8
    t.string "next_time", limit: 128
    t.string "latency", limit: 8
    t.date "last_time"
    t.decimal "jobno"
    t.index ["jobno"], name: "aq$_schedules_check", unique: true
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id", precision: 38
    t.string "auditable_type"
    t.integer "associated_id", precision: 38
    t.string "associated_type"
    t.integer "user_id", precision: 38
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", precision: 38, default: 0
    t.string "comment"
    t.string "remote_address"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index"
    t.index ["auditable_id", "auditable_type"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["user_id", "user_type"], name: "user_index"
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
    t.string "upi_enabled", limit: 1, default: "Y", null: false, comment: "the flag which indicates whether this bank is upi enabled or not"
    t.string "created_user"
    t.string "updated_user"
    t.string "created_or_edited_by"
    t.string "audits"
    t.string "audit"
    t.index ["ifsc", "approval_status"], name: "index_banks_on_ifsc_and_approval_status", unique: true
  end

  create_table "bm_apps", force: :cascade do |t|
    t.string "app_id", limit: 20, null: false
    t.string "channel_id", limit: 20, null: false
    t.integer "lock_version", precision: 38, null: false
    t.string "approval_status", limit: 1, null: false
    t.string "last_action", limit: 1
    t.integer "approved_version", precision: 38
    t.integer "approved_id", precision: 38
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bm_bill_payments", force: :cascade do |t|
    t.string "app_id", limit: 50, null: false, comment: "the identifier for the client"
    t.string "req_no", limit: 32, null: false, comment: "the unique request number sent by the client"
    t.integer "attempt_no", precision: 38, null: false, comment: "the attempt number of the request, failed requests can be retried"
    t.string "req_version", limit: 5, null: false, comment: "the service version number received in the request"
    t.datetime "req_timestamp", null: false, comment: "the SYSDATE when the request was received"
    t.string "customer_id", limit: 15, null: false, comment: "the unique id of the customer that initiated the request"
    t.string "debit_account_no", limit: 50, null: false, comment: "the account chosen by the customer to be debited"
    t.string "txn_kind", limit: 50, null: false, comment: "the kind of the transaction: specifies which of biller_code, biller_account_no, bill_id will be available"
    t.integer "txn_amount", precision: 38, null: false, comment: "the transaction amount"
    t.string "biller_code", limit: 50, null: false, comment: "the biller account registered for the customer, this identifies the biller and parameters"
    t.string "biller_acct_no", limit: 50, comment: "the biller account registered for the customer, this identifies the biller and parameters"
    t.string "bill_id", limit: 50, comment: "the unique identifier of the bill, as received in getBill operation"
    t.string "status", limit: 50, null: false, comment: "the status of the transaction"
    t.string "fault_code", limit: 50, comment: "the code that identifies the business failure reason/exception"
    t.string "fault_reason", limit: 1000, comment: "the english reason of the business failure reason/exception "
    t.string "debit_req_ref", limit: 64, comment: "the reference number of the debit request"
    t.integer "debit_attempt_no", precision: 38, comment: "the last attempt no of the debit request"
    t.datetime "debit_attempt_at", comment: "the SYSDATE when the last/next attempt was/will happen"
    t.string "debit_rep_ref", limit: 64, comment: "the reference number as received in the debit reply"
    t.datetime "debited_at", comment: "the SYSDATE when the debit completed"
    t.string "billpay_req_ref", limit: 64, comment: "the reference number of the bill payment request"
    t.integer "billpay_attempt_no", precision: 38, comment: "the last attempt no of the bill payment request"
    t.datetime "billpay_attempt_at", comment: "the SYSDATE when the last/next attempt was/will happen"
    t.string "billpay_rep_ref", limit: 64, comment: "the reference number as received in the billpay reply"
    t.datetime "billpaid_at", comment: "the SYSDATE when the billpay completed"
    t.string "reversal_req_ref", limit: 64, comment: "the reference number of the debit reversal"
    t.integer "reversal_attempt_no", precision: 38, comment: "the last attempt no of the debit reversal "
    t.datetime "reversal_attempt_at", comment: "the SYSDATE when the last/next attempt was/will happen"
    t.string "reversal_rep_ref", limit: 64, comment: "the reference number as received in the reversal reply"
    t.datetime "reversal_at", comment: "the SYSDATE when the reversal reply was received"
    t.string "refund_ref", limit: 64, comment: "the reference number of the refund transaction"
    t.datetime "refund_at", comment: "the SYSDATE when the refund was completed"
    t.string "is_reconciled", limit: 1, comment: "the status indicator to denote reconciled payments"
    t.datetime "reconciled_at", comment: "the SYSDATE when the transaction was reconciled"
    t.string "billpay_bank_ref", limit: 20
    t.index ["app_id", "req_no", "attempt_no"], name: "attepmt_index_bill_payments", unique: true
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
    t.string "app_id", limit: 50, comment: "the app_id for the rule"
    t.index ["app_id", "approval_status"], name: "bm_rules_01", unique: true
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
    t.string "allow_return_by_rtgs", default: "N", null: false, comment: "the flag which indicates whether return is allowed by RTGS or not"
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

  create_table "ft_apbs_incoming_files", force: :cascade do |t|
    t.string "file_name", limit: 50, comment: "the name of the incoming file"
    t.index ["file_name"], name: "ft_apbs_incoming_files_01", unique: true
  end

  create_table "ft_audit_steps", force: :cascade do |t|
    t.string "ft_auditable_type", null: false, comment: "the name of the table that represents the request that is related to this record"
    t.integer "ft_auditable_id", precision: 38, null: false, comment: "the id of the row that represents the request that is related to this recrod"
    t.integer "step_no", precision: 38, null: false, comment: "the step of the transaction, for which this record exists"
    t.integer "attempt_no", precision: 38, null: false, comment: "the attempt number of the request, failed requests can be retried"
    t.string "step_name", limit: 100, null: false, comment: "the english name of the step: create user, request token, access token, modify user, add address, add card, activate card"
    t.string "status_code", limit: 30, null: false, comment: "the status of the request"
    t.string "fault_code", comment: "the code that identifies the exception, if an exception occured in the ESB"
    t.string "fault_subcode", limit: 50, comment: "the error code that the third party will return"
    t.string "fault_reason", limit: 1000, comment: "the english reason of the exception, if an exception occurred in the ESB"
    t.string "req_reference", comment: "the reference number that was sent to the service provider"
    t.datetime "req_timestamp", comment: "the SYSDATE when the request was sent to the service provider"
    t.string "rep_reference", comment: "the reference number as received from ther service provider"
    t.datetime "rep_timestamp", comment: "the SYSDATE when the reply was sent to the client"
    t.text "req_bitstream", comment: "the full request payload as received from the client"
    t.text "rep_bitstream", comment: "the full reply payload as sent to the client"
    t.text "fault_bitstream", comment: "the complete exception list/stack trace of an exception that occured in the ESB"
    t.string "remote_host", limit: 500, comment: "the URL of the calling service"
    t.string "req_uri", limit: 500, comment: "the URI of the calling service"
    t.text "req_header", comment: "the header which will be passed along with the request"
    t.text "rep_header", comment: "the header which comes after calling the service"
    t.index ["ft_auditable_type", "ft_auditable_id", "step_no", "attempt_no"], name: "uk_ft_audit_steps", unique: true
  end

  create_table "ft_cust_accounts", force: :cascade do |t|
    t.string "customer_id", limit: 15, null: false, comment: "the id of the customer"
    t.string "account_no", limit: 20, null: false, comment: "the account no of the customer, that is approved for access via the service"
    t.string "is_enabled", limit: 1, null: false, comment: "the flag to decide if the account is enabled or not"
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.datetime "updated_at", null: false, comment: "the timestamp when the record was last updated"
    t.string "created_by", limit: 20, comment: "the person who creates the record"
    t.string "updated_by", limit: 20, comment: "the person who updates the record"
    t.integer "lock_version", precision: 38, default: 0, null: false, comment: "the version number of the record, every update increments this by 1"
    t.string "approval_status", limit: 1, default: "U", null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
    t.string "last_action", limit: 1, default: "C", null: false, comment: "the last action (create, update) that was performed on the record"
    t.integer "approved_version", precision: 38, comment: "the version number of the record, at the time it was approved"
    t.integer "approved_id", precision: 38, comment: "the id of the record that is being updated"
    t.index ["customer_id", "account_no", "approval_status"], name: "ft_cust_accounts_01", unique: true
  end

  create_table "ft_customer_disable_lists", force: :cascade do |t|
    t.string "app_id"
    t.string "customer_id"
    t.integer "user_id", precision: 38
    t.string "approval_status", limit: 1, default: "U"
    t.integer "approved_version", precision: 38
    t.integer "approved_id", precision: 38
    t.string "last_action", limit: 1, default: "C"
    t.string "created_by", limit: 20
    t.string "updated_by", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ft_incoming_files", force: :cascade do |t|
    t.string "file_name", limit: 50, comment: "the name of the incoming_file"
    t.string "customer_code", limit: 15, comment: "the customer code"
    t.index ["file_name"], name: "ft_incoming_files_01", unique: true
  end

  create_table "ft_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id", precision: 38, comment: "the foreign key to the incoming_files table"
    t.string "file_name", limit: 50, comment: "the name of the incoming_file"
    t.string "req_version", limit: 10, comment: " the number send in the request, this reflects the version that is known to the client"
    t.string "req_no", limit: 50, comment: "the unique reference number to be sent by the client application"
    t.string "app_id", limit: 20, comment: "the unique ID assigned to every application"
    t.string "purpose_code", limit: 20, comment: "the purpose of the transaction"
    t.string "customer_code", limit: 50, comment: "the unique id assigned to customer"
    t.string "debit_account_no", limit: 20, comment: "the account to be debited for the funds transfer"
    t.string "bene_code", limit: 50, comment: "the code assigned to the beneficiary by the customer"
    t.string "bene_full_name", limit: 100, comment: "the full name of the beneficiary"
    t.string "bene_address1", comment: "the address1 of the beneficiary"
    t.string "bene_address2", comment: "the address2 of the beneficiary"
    t.string "bene_address3", limit: 100, comment: "the address3 of the beneficiary"
    t.string "bene_postal_code", limit: 100, comment: "the postal code of the beneficiary"
    t.string "bene_city", limit: 100, comment: "the city name of the beneficiary"
    t.string "bene_state", limit: 100, comment: "the state name of the beneficiary"
    t.string "bene_country", limit: 100, comment: "the country name of the beneficiary"
    t.string "bene_mobile_no", limit: 10, comment: "the mobile no of the beneficiary"
    t.string "bene_email_id", limit: 100, comment: " the email id of the beneficiary"
    t.string "bene_account_no", limit: 20, comment: "the account no of the beneficiary"
    t.string "bene_ifsc_code", limit: 50, comment: "the ifsc code of the beneficiary account"
    t.string "bene_mmid", limit: 50, comment: "the mmid of the beneficary to do IMPS transaction"
    t.string "bene_mmid_mobile_no", limit: 50, comment: "the network that supports the MMID method of payment"
    t.string "req_transfer_type", limit: 4, comment: "the type of the transfer e.g. NEFT/IMPS/FT/RTGS"
    t.string "transfer_ccy", limit: 5, comment: "the transfer currency code"
    t.integer "transfer_amount", precision: 38, comment: "the amount which has to be transferred to the beneficiary"
    t.string "rmtr_to_bene_note", comment: "the friendly note from the remitter to the beneficiary"
    t.string "rep_version", limit: 10, comment: " the number comes in the reply, this reflects the version that is known to the server"
    t.string "rep_no", limit: 50, comment: "the unique response no sent by API"
    t.integer "rep_attempt_no", precision: 38, comment: "the attempt no returned in the response by the api"
    t.string "transfer_type", limit: 4, comment: "the type of the transfer which has been used for transactions"
    t.string "low_balance_alert", comment: "the low balance threshold can be configured for the partners, If the balance in the drawing account drops below this threshold, then the value for this identifier will be true else false"
    t.string "txn_status_code", limit: 50, comment: "the status of the transaction"
    t.string "txn_status_subcode", limit: 50, comment: "the detailed error code that was received from the beneficiary bank"
    t.string "bank_ref_no", limit: 50, comment: "the reference number generated by the bank, and passed on to the payment network"
    t.string "bene_ref_no", limit: 50, comment: "for future use"
    t.string "name_with_bene_bank", comment: "the name as registered with the beneficiary bank"
    t.string "aadhaar_no", limit: 12, comment: "the aadhar number of the beneficiary for apbs transfer type"
    t.string "aadhaar_mobile_no", limit: 20, comment: "the mobile number which linked with aadhar for APBS transfer type"
    t.index ["incoming_file_record_id"], name: "ft_incoming_records_01", unique: true
  end

  create_table "ft_invoice_details", force: :cascade do |t|
    t.string "req_no", limit: 50, null: false, comment: "the unique request number for the transaction"
    t.string "req_version", limit: 10, null: false, comment: "the request version"
    t.datetime "req_timestamp", null: false, comment: "the request timestamp"
    t.string "app_id", limit: 20, null: false, comment: "the unique id assigned to a client app"
    t.string "customer_id", limit: 15, null: false, comment: "the ID of the customer"
    t.string "customer_name", limit: 50, comment: "the name of the customer"
    t.string "status_code", limit: 50, null: false, comment: "the status of this request"
    t.integer "attempt_no", precision: 38, null: false, comment: "the attempt number of the request, failed requests can be retried"
    t.string "supplier_code", limit: 20, comment: "The Code Assigned to the supplier by the customer"
    t.string "purchase_order_number", limit: 50, comment: "The list of invoices paid (one payment can be made for multiple invoices). The sum of paidAmount should match transferAmount"
    t.string "invoice_number", limit: 50, comment: "The Invoice Number"
    t.datetime "invoice_date", comment: "The Invoice Date"
    t.string "payment_reference", comment: "The payment reference for this invoice (different than the UTR for the payment)"
    t.string "note", comment: "A free format note for the invoice"
    t.string "gstin", limit: 50, comment: "Customer GSTIN number ,GST registration number"
    t.string "advice_file_name", limit: 100, comment: "the name of the advice file"
    t.string "cnb_file_name", limit: 100, comment: "the name of the cnb file"
    t.string "advice_status", limit: 50, comment: "the status of the advice"
    t.string "advice_email_id", limit: 100, comment: "the email id on which advice has been sent"
    t.datetime "advice_sent_at", comment: "the timestamp when advice has been sent"
    t.integer "funds_transfer_id", precision: 38, comment: "the id for the transfer in funds transfers table"
    t.string "rep_no", limit: 50, comment: "the unique response no sent by API"
    t.string "rep_version", limit: 10, comment: " the number comes in the reply, this reflects the version that is known to the server"
    t.datetime "rep_timestamp", comment: "the SYSDATE when the reply was sent to the client"
    t.string "fault_code", limit: 50, comment: "the code that identifies the business failure reason/exception"
    t.string "fault_reason", limit: 1000, comment: "the english reason of the business failure reason/exception"
    t.string "fault_subcode", limit: 50, comment: "the error code that the third party will return"
    t.index ["customer_id", "req_no", "attempt_no"], name: "ft_invoice_details_01", unique: true
  end

  create_table "ft_pending_advices", force: :cascade do |t|
    t.string "broker_uuid", null: false, comment: "the UUID of the broker"
    t.integer "ft_invoice_detail_id", precision: 38, null: false, comment: "the id of the funds transfers invioce detail table"
    t.integer "funds_transfer_id", precision: 38, comment: "the id of the funds transfer record"
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.index ["ft_invoice_detail_id", "funds_transfer_id"], name: "ft_pending_advices_01", unique: true
  end

  create_table "ft_pending_confirmations", force: :cascade do |t|
    t.string "broker_uuid", null: false, comment: "the UUID of the broker"
    t.string "ft_auditable_type", null: false, comment: "the name of the table that represents the request that is related to this record"
    t.integer "ft_auditable_id", precision: 38, null: false, comment: "the id of the row that represents the request that is related to this record"
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.index ["broker_uuid"], name: "ft_confirmations_02"
    t.index ["ft_auditable_type", "ft_auditable_id"], name: "ft_confirmations_01", unique: true
  end

  create_table "ft_purge_saf_transfers", force: :cascade do |t|
    t.string "reference_no", limit: 100, null: false, comment: "the ID of the customer whose transactions are to be deleted"
    t.datetime "from_req_timestamp", null: false, comment: "the starting date for the request timestamp from which the transactions are to be deleted"
    t.datetime "to_req_timestamp", null: false, comment: "the ending date for the request timestamp upto which the transactions are to be deleted"
    t.string "customer_id", limit: 15, comment: "the ID of the customer whose transactions are to be deleted"
    t.string "op_name", limit: 32, comment: "the name of the operation whose transactions are to be deleted"
    t.string "req_transfer_type", limit: 4, comment: "the type of the transfer e.g. NEFT/IMPS/FT/RTGS whose transactions are to be deleted"
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.datetime "updated_at", null: false, comment: "the timestamp when the record was last updated"
    t.string "created_by", limit: 20, comment: "the person who creates the record"
    t.string "updated_by", limit: 20, comment: "the person who updates the record"
    t.integer "lock_version", precision: 38, default: 0, null: false, comment: "the version number of the record, every update increments this by 1"
    t.string "last_action", limit: 1, default: "C", null: false, comment: "the last action (create, update) that was performed on the record"
    t.string "approval_status", limit: 1, default: "U", null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
    t.integer "approved_version", precision: 38, comment: "the version number of the record, at the time it was approved"
    t.integer "approved_id", precision: 38, comment: "the id of the record that is being updated"
    t.index ["reference_no", "approval_status"], name: "ft_purge_saf_transfers_01", unique: true
  end

  create_table "ft_purpose_codes", force: :cascade do |t|
    t.string "code", limit: 20, null: false, comment: "the purpose code"
    t.string "description", limit: 100, comment: "the description for this purpose code"
    t.string "is_enabled", limit: 1, comment: "the flag which indicates if this purpose code is enabled or not"
    t.string "allow_only_registered_bene", limit: 1, comment: "the flag which indicates whether only registered beneficiary is allowed"
    t.string "created_by", limit: 20, comment: "the person who creates the record"
    t.string "updated_by", limit: 20, comment: "the person who updates the record"
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.datetime "updated_at", null: false, comment: "the timestamp when the record was last updated"
    t.integer "lock_version", precision: 38, default: 0, null: false, comment: "the version number of the record, every update increments this by 1"
    t.string "approval_status", limit: 1, default: "U", null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
    t.string "last_action", limit: 1, default: "C", null: false, comment: "the last action (create, update) that was performed on the record"
    t.integer "approved_version", precision: 38, comment: "the version number of the record, at the time it was approved"
    t.integer "approved_id", precision: 38, comment: "the id of the record that is being updated"
    t.string "is_frozen", limit: 1, default: "N", null: false, comment: "the flag which ensures the values other than is_enabled is not changed by users"
    t.index ["code", "approval_status"], name: "uk_ft_purpose_codes", unique: true
  end

  create_table "ft_saf_transfers", force: :cascade do |t|
    t.string "app_uuid", comment: "the UUID of the instance of the application"
    t.string "customer_id", limit: 15, comment: "the ID of the customer"
    t.string "req_no", limit: 32, null: false, comment: "the unique request number sent by the client"
    t.string "op_name", limit: 32, null: false, comment: "the name of the operation from where the transaction has come"
    t.string "req_transfer_type", limit: 4, comment: "the type of the transfer e.g. NEFT/IMPS/FT/RTGS"
    t.datetime "req_timestamp", null: false, comment: "the SYSDATE when the request was received"
    t.datetime "rep_timestamp", comment: "the SYSDATE when the reply was sent to the client"
    t.text "req_bitstream", comment: "the full request payload as received from the client"
    t.text "rep_bitstream", comment: "the full reply payload as sent to the client"
    t.index ["customer_id", "req_no"], name: "ft_saf_transfers_01", unique: true
    t.index ["req_timestamp", "req_transfer_type", "customer_id"], name: "ft_saf_transfers_02"
  end

  create_table "ft_tmp_audit_logs", force: :cascade do |t|
    t.string "req_no", limit: 50, null: false, comment: "the unique request number for the transaction"
    t.string "app_id", limit: 20, null: false, comment: "the unique id assigned to a client app"
    t.string "customer_id", limit: 15, null: false, comment: "the ID of the customer"
    t.integer "ft_invoice_detail_id", precision: 38, comment: "the name of the table that represents the request that is related to this record"
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.text "req_bitstream", comment: "the full request payload as received from the client"
    t.index ["ft_invoice_detail_id", "req_no", "app_id", "customer_id"], name: "ft_tmp_audit_logs_01", unique: true
  end

  create_table "ft_unapproved_records", force: :cascade do |t|
    t.integer "ft_approvable_id", precision: 38
    t.string "ft_approvable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "help", primary_key: ["topic", "seq"], force: :cascade do |t|
    t.string "topic", limit: 50, null: false
    t.decimal "seq", null: false
    t.string "info", limit: 80
  end

  create_table "iam_audit_logs", force: :cascade do |t|
    t.string "org_uuid", null: false, comment: "the UUID of the organisation as available in DP"
    t.string "cert_dn", limit: 300, comment: "to specify the DN of the certificate (required when then customer is not using VPN)"
    t.string "source_ip", limit: 100, comment: "the source ip-address (required when the customer is not using VPN)"
    t.text "req_bitstream", comment: "the full request payload as received from the client"
    t.text "rep_bitstream", comment: "the full reply payload as sent to the client"
    t.datetime "req_timestamp", null: false, comment: "the SYSDATE when the request was received"
    t.datetime "rep_timestamp", comment: "the SYSDATE when the reply was sent to the client"
    t.string "fault_code", limit: 50, comment: "the code that identifies the business failure reason/exception"
    t.string "fault_reason", limit: 1000, comment: "the english reason of the business failure reason/exception"
    t.index ["org_uuid"], name: "iam_audit_logs_01"
  end

  create_table "iam_audit_rules", force: :cascade do |t|
    t.integer "interval_in_mins", precision: 38, default: 15, null: false, comment: "the log interval in mins till when the enabled failures will get logged"
    t.string "created_by", limit: 20, comment: "the person who creates the record"
    t.string "updated_by", limit: 20, comment: "the person who updates the record"
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.datetime "updated_at", null: false, comment: "the timestamp when the record was last updated"
    t.integer "lock_version", precision: 38, default: 0, null: false, comment: "the version number of the record, every update increments this by 1"
    t.string "log_bad_org_uuid", limit: 1, default: "N", null: false, comment: "the timestamp when the log was last enabled"
    t.integer "iam_organisation_id", precision: 38, comment: "the organisation for which the log is enabled (only 1 org is enabled at a time)"
    t.datetime "enabled_at", default: "2023-08-25 11:36:56", null: false, comment: "the timestamp when the log was last enabled"
  end

  create_table "iam_cust_users", force: :cascade do |t|
    t.string "username", limit: 100, null: false, comment: "the username in the LDAP, this is unique across customers"
    t.string "first_name", comment: "the first name of the individual to whom the username is assigned"
    t.string "last_name", limit: 100, comment: "the last name of the individual to whom the username is assigned"
    t.string "email", limit: 100, comment: "the email address of the individual to whom the username is assigned, the password is sent to this email"
    t.string "mobile_no", limit: 20, comment: "the mobile no of the individual to whom the username is assigned, the password is sent to this number"
    t.string "encrypted_password", comment: "the encrypted password that was set or generated for the user"
    t.string "should_reset_password", limit: 1, comment: "the indicator that specifies whether a password reset is being initiated"
    t.string "was_user_added", limit: 1, comment: "the indicator that specifies whether this user was successfully added to ldap or not"
    t.datetime "last_password_reset_at", comment: "the last time the password was reset for this user"
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.datetime "updated_at", null: false, comment: "the timestamp when the record was last updated"
    t.string "created_by", limit: 20, comment: "the person who creates the record"
    t.string "updated_by", limit: 20, comment: "the person who updates the record"
    t.integer "lock_version", precision: 38, default: 0, null: false, comment: "the version number of the record, every update increments this by 1"
    t.string "last_action", limit: 1, default: "C", null: false, comment: "the last action (create, update) that was performed on the record"
    t.string "approval_status", limit: 1, default: "U", null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
    t.integer "approved_version", precision: 38, comment: "the version number of the record, at the time it was approved"
    t.integer "approved_id", precision: 38, comment: "the id of the record that is being updated"
    t.datetime "notification_sent_at", comment: "the timestamp when the notification was sent to the user"
    t.string "is_enabled", default: "Y", comment: "the flag which indicates whether this user is enabled or not"
    t.string "secondary_email"
    t.string "secondary_mobile_no"
    t.boolean "is_sms", default: false
    t.boolean "is_email", default: false
    t.string "send_password_via"
    t.index ["username", "approval_status"], name: "iam_cust_users_01", unique: true
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
    t.index ["customer_id", "app_id", "req_no", "attempt_no", "status_code", "req_timestamp", "rep_timestamp"], name: "imt_add_beneficiaries_01"
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
    t.index ["customer_id", "app_id", "req_no", "attempt_no", "status_code", "req_timestamp", "rep_timestamp"], name: "imt_cancel_transfers_01"
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
    t.string "last_action", default: "C"
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
    t.index ["customer_id", "app_id", "req_no", "attempt_no", "status_code", "req_timestamp", "rep_timestamp"], name: "imt_del_beneficiaries_01"
    t.index ["req_no", "app_id", "attempt_no"], name: "uk_imt_del_bene", unique: true
  end

  create_table "imt_incoming_files", force: :cascade do |t|
    t.string "file_name", limit: 50, comment: "the name of the incoming_file"
    t.index ["file_name"], name: "imt_incoming_files_01", unique: true
  end

  create_table "imt_incoming_records", force: :cascade do |t|
    t.integer "incoming_file_record_id", precision: 38, null: false, comment: "the foreign key to the incoming_files table"
    t.string "file_name", limit: 50, null: false, comment: "the name of the incoming_file"
    t.integer "record_no", precision: 38, null: false, comment: "the serial no of the imt transaction which has come in the file"
    t.string "issuing_bank", comment: "the name of the bank which issued"
    t.string "acquiring_bank", comment: "the name of the bank that processes payments on behalf of merchant"
    t.string "imt_ref_no", comment: "the unique reference no through which imt has been initiated"
    t.datetime "txn_issue_date", comment: "the timestamp of the transaction when it has been issued"
    t.datetime "txn_acquire_date", comment: "the timestamp when the transaction was created"
    t.datetime "chargeback_action_date", comment: "the timestamp of the return of funds to a consumer, forcibly initiated by the issuing bank of the instrument used by a consumer to settle a debt"
    t.string "issuing_bank_txn_id", comment: "the transaction id of the bank which issued"
    t.string "acquiring_bank_txn_id", comment: "the transaction id of the acquiring bank"
    t.string "txn_status", comment: "the status of the imt transaction"
    t.string "crdr", comment: "the flag that indicates either debited or credited"
    t.datetime "settlement_at", comment: "the datetime when the settlement happened"
    t.string "settlement_status", limit: 15, comment: "the settlement status of the IMT transaction"
    t.integer "settlement_attempt_no", precision: 38, comment: "the attempt number which has been made for IMT settlement"
    t.string "settlement_bank_ref", comment: "the unique reference no which has been sent to FCR api while doing settlement"
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
    t.index ["customer_id", "app_id", "req_no", "attempt_no", "status_code", "req_timestamp", "rep_timestamp"], name: "imt_initiate_transfers_01"
    t.index ["req_no", "app_id", "attempt_no"], name: "uk_imt_tranfers", unique: true
  end

  create_table "imt_pending_steps", force: :cascade do |t|
    t.string "broker_uuid", null: false
    t.datetime "created_at", null: false
    t.integer "imt_audit_step_id", precision: 38, default: 1, null: false
  end

  create_table "imt_resend_otp", force: :cascade do |t|
    t.string "req_no", limit: 30, null: false, comment: "the unique reference number to be sent by the client application"
    t.integer "attempt_no", precision: 38, null: false, comment: "the attempt number of the request, failed requests can be retried"
    t.string "status_code", limit: 25, null: false, comment: "the status of this request"
    t.string "req_version", limit: 10, null: false, comment: "the service version number received in the request"
    t.datetime "req_timestamp", null: false, comment: "the SYSDATE when the request was sent to the service provider"
    t.string "app_id", limit: 50, null: false, comment: "the identifier for the client"
    t.string "customer_id", limit: 50, null: false, comment: "the unique no of the customer"
    t.string "imt_ref_no", limit: 32, comment: "the reference number generated by IMT"
    t.string "initiate_transfer_no", limit: 50, null: false, comment: "the unique request no which has been sent during transfer initiation"
    t.string "rep_no", limit: 32, comment: "the unique response number sent back by the API"
    t.string "rep_version", limit: 10, comment: "the service version sent in the reply"
    t.integer "otp_attempt_no", precision: 38, comment: "the attempt number of the send otp while initiating IMT"
    t.datetime "rep_timestamp", comment: "the SYSDATE when the reply was sent to the client"
    t.string "fault_code", limit: 50, comment: "the code that identifies the business failure reason/exception"
    t.string "fault_subcode", limit: 50, comment: "the error code that the third party will return"
    t.string "fault_reason", limit: 1000, comment: "the english reason of the business failure reason/exception"
    t.index ["customer_id", "app_id", "req_no", "attempt_no", "status_code", "req_timestamp", "rep_timestamp"], name: "imt_resend_otp_01"
    t.index ["req_no", "app_id", "attempt_no"], name: "uk_imt_resend_otp", unique: true
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
    t.string "app_id", limit: 20, null: false, comment: "the app Id issued to the customer"
    t.datetime "settlement_at", comment: "the datetime when the settlement happened"
    t.string "settlement_status", limit: 15, comment: "the settlement status of the IMT transaction"
    t.integer "settlement_attempt_no", precision: 38, comment: "the attempt number which has been made for IMT settlement"
    t.string "settlement_bank_ref", comment: "the unique reference no which has been sent to FCR api while doing settlement"
    t.integer "incoming_file_record_id", precision: 38, comment: "the foreign key to the imt_incoming_records table, which has been for settlement"
    t.string "file_name", limit: 100, comment: "the name of the file which has been used for settlement"
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

  create_table "incoming_files", force: :cascade do |t|
    t.string "service_name", limit: 10
    t.string "file_type", limit: 10
    t.string "file"
    t.string "file_name", limit: 50
    t.integer "size_in_bytes", precision: 38
    t.integer "line_count", precision: 38
    t.string "status", limit: 1
    t.date "started_at"
    t.date "ended_at"
    t.string "created_by", limit: 20
    t.string "updated_by", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inw_guidelines", force: :cascade do |t|
    t.string "code", limit: 5, null: false, comment: "the identifier for the guideline"
    t.string "allow_neft", limit: 1, default: "Y", null: false, comment: "the indicator to specify if the guideline allows neft"
    t.string "allow_imps", limit: 1, default: "Y", null: false, comment: "the indicator to specify if the guideline allows imps"
    t.string "allow_rtgs", limit: 1, default: "Y", null: false, comment: "the indicator to specify if the guideline allows rtgs"
    t.integer "ytd_txn_cnt_bene", precision: 38, comment: "the count of transactions allowed for a beneficiary in a calendar year"
    t.text "disallowed_products", comment: "the list of product code which are disallowed for guideline"
    t.string "needs_lcy_rate", limit: 1, default: "N", null: false, comment: "the indicator to specify if lcy_rate is required for this guideline"
    t.string "is_enabled", limit: 1, default: "Y", null: false, comment: "the indicator to specify if the guideline is enabled or not"
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.datetime "updated_at", null: false, comment: "the timestamp when the record was last updated"
    t.string "created_by", limit: 20, comment: "the person who creates the record"
    t.string "updated_by", limit: 20, comment: "the person who updates the record"
    t.integer "lock_version", precision: 38, default: 0, null: false, comment: "the version number of the record, every update increments this by 1"
    t.string "approval_status", limit: 1, default: "U", null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
    t.string "last_action", limit: 1, default: "C", null: false, comment: "the last action (create, update) that was performed on the record"
    t.integer "approved_version", precision: 38, comment: "the version number of the record, at the time it was approved"
    t.integer "approved_id", precision: 38, comment: "the id of the record that is being updated"
    t.index ["code", "approval_status"], name: "inw_guidelines_01", unique: true
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
    t.string "pattern_remitters", limit: 4000
    t.string "approval_status", limit: 1, default: "U", null: false
    t.string "last_action", limit: 1, default: "C"
    t.integer "approved_version", precision: 38
    t.integer "approved_id", precision: 38
  end

  create_table "inw_unapproved_records", force: :cascade do |t|
    t.integer "inw_approvable_id", precision: 38
    t.string "inw_approvable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inward_remittances", force: :cascade do |t|
    t.string "req_transfer_type", limit: 4
    t.decimal "bal_available"
    t.string "service_id"
    t.date "reconciled_at"
    t.string "cbs_req_ref_no"
    t.datetime "processed_at", comment: "the timestamp when transaction has processed successfully"
    t.string "notify_status", limit: 100, comment: "the status of the notify step for e.g., NOTIFIED:OK, NOTIFY:REJECTED, NOTIFICATION FAILED and PENDING NOTIFICATION"
    t.string "rmtr_code", limit: 50, comment: "the partner assigned code of the remitter to which the identity belongs"
    t.string "payervpa"
    t.string "payeevpa"
  end

  create_table "inward_remittances_locks", id: false, force: :cascade do |t|
    t.integer "inward_remittance_id", precision: 38
    t.string "created_at"
  end

  create_table "mview$_adv_ajg", primary_key: "ajgid#", id: :decimal, comment: "Anchor-join graph representation", force: :cascade do |t|
    t.decimal "runid#", null: false
    t.decimal "ajgdeslen", null: false
    t.raw "ajgdes", null: false
    t.decimal "hashvalue", null: false
    t.decimal "frequency"
  end

  create_table "mview$_adv_basetable", id: false, comment: "Base tables refered by a query", force: :cascade do |t|
    t.decimal "collectionid#", null: false
    t.decimal "queryid#", null: false
    t.string "owner", limit: 128
    t.string "table_name", limit: 128
    t.decimal "table_type"
    t.index ["queryid#"], name: "mview$_adv_basetable_idx_01"
  end

  create_table "mview$_adv_clique", primary_key: "cliqueid#", id: :decimal, comment: "Table for storing canonical form of Clique queries", force: :cascade do |t|
    t.decimal "runid#", null: false
    t.decimal "cliquedeslen", null: false
    t.raw "cliquedes", null: false
    t.decimal "hashvalue", null: false
    t.decimal "frequency", null: false
    t.decimal "bytecost", null: false
    t.decimal "rowsize", null: false
    t.decimal "numrows", null: false
  end

  create_table "mview$_adv_eligible", primary_key: ["sumobjn#", "runid#"], comment: "Summary management rewrite eligibility information", force: :cascade do |t|
    t.decimal "sumobjn#", null: false
    t.decimal "runid#", null: false
    t.decimal "bytecost", null: false
    t.decimal "flags", null: false
    t.decimal "frequency", null: false
  end

# Could not dump table "mview$_adv_exceptions" because of following StandardError
#   Unknown type 'ROWID' for column 'bad_rowid'

  create_table "mview$_adv_filter", primary_key: ["filterid#", "subfilternum#"], comment: "Table for workload filter definition", force: :cascade do |t|
    t.decimal "filterid#", null: false
    t.decimal "subfilternum#", null: false
    t.decimal "subfiltertype", null: false
    t.string "str_value", limit: 1028
    t.decimal "num_value1"
    t.decimal "num_value2"
    t.date "date_value1"
    t.date "date_value2"
  end

  create_table "mview$_adv_filterinstance", id: false, comment: "Table for workload filter instance definition", force: :cascade do |t|
    t.decimal "runid#", null: false
    t.decimal "filterid#"
    t.decimal "subfilternum#"
    t.decimal "subfiltertype"
    t.string "str_value", limit: 1028
    t.decimal "num_value1"
    t.decimal "num_value2"
    t.date "date_value1"
    t.date "date_value2"
  end

  create_table "mview$_adv_fjg", primary_key: "fjgid#", id: :decimal, comment: "Representation for query join sub-graph not in AJG ", force: :cascade do |t|
    t.decimal "ajgid#", null: false
    t.decimal "fjgdeslen", null: false
    t.raw "fjgdes", null: false
    t.decimal "hashvalue", null: false
    t.decimal "frequency"
  end

  create_table "mview$_adv_gc", primary_key: "gcid#", id: :decimal, comment: "Group-by columns of a query", force: :cascade do |t|
    t.decimal "fjgid#", null: false
    t.decimal "gcdeslen", null: false
    t.raw "gcdes", null: false
    t.decimal "hashvalue", null: false
    t.decimal "frequency"
  end

  create_table "mview$_adv_info", primary_key: ["runid#", "seq#"], comment: "Internal table for passing information from the SQL analyzer", force: :cascade do |t|
    t.decimal "runid#", null: false
    t.decimal "seq#", null: false
    t.decimal "type", null: false
    t.decimal "infolen", null: false
    t.raw "info"
    t.decimal "status"
    t.decimal "flag"
  end

# Could not dump table "mview$_adv_journal" because of following StandardError
#   Unknown type 'LONG' for column 'text'

  create_table "mview$_adv_level", primary_key: ["runid#", "levelid#"], comment: "Level definition", force: :cascade do |t|
    t.decimal "runid#", null: false
    t.decimal "levelid#", null: false
    t.decimal "dimobj#"
    t.decimal "flags", null: false
    t.decimal "tblobj#", null: false
    t.raw "columnlist", limit: 70, null: false
    t.string "levelname", limit: 128
  end

  create_table "mview$_adv_log", primary_key: "runid#", id: :decimal, comment: "Log all calls to summary advisory functions", force: :cascade do |t|
    t.decimal "filterid#"
    t.date "run_begin"
    t.date "run_end"
    t.decimal "run_type"
    t.string "uname", limit: 128
    t.decimal "status", null: false
    t.string "message", limit: 2000
    t.decimal "completed"
    t.decimal "total"
    t.string "error_code", limit: 20
  end

# Could not dump table "mview$_adv_output" because of following StandardError
#   Unknown type 'LONG' for column 'query_text'

  create_table "mview$_adv_parameters", primary_key: "parameter_name", id: { type: :string, limit: 128 }, comment: "Summary advisor tuning parameters", force: :cascade do |t|
    t.decimal "parameter_type", null: false
    t.string "string_value", limit: 30
    t.date "date_value"
    t.decimal "numerical_value"
  end

# Could not dump table "mview$_adv_plan" because of following StandardError
#   Unknown type 'LONG' for column 'other'

# Could not dump table "mview$_adv_pretty" because of following StandardError
#   Unknown type 'LONG' for column 'sql_text'

  create_table "mview$_adv_rollup", primary_key: ["runid#", "clevelid#", "plevelid#"], comment: "Each row repesents either a functional dependency or join-key relationship", force: :cascade do |t|
    t.decimal "runid#", null: false
    t.decimal "clevelid#", null: false
    t.decimal "plevelid#", null: false
    t.decimal "flags", null: false
  end

  create_table "mview$_adv_sqldepend", id: false, comment: "Temporary table for workload collections", force: :cascade do |t|
    t.decimal "collectionid#"
    t.decimal "inst_id"
    t.raw "from_address", limit: 16
    t.decimal "from_hash"
    t.string "to_owner", limit: 128
    t.string "to_name", limit: 1000
    t.decimal "to_type"
    t.decimal "cardinality"
    t.index ["collectionid#", "from_address", "from_hash", "inst_id"], name: "mview$_adv_sqldepend_idx_01"
  end

# Could not dump table "mview$_adv_temp" because of following StandardError
#   Unknown type 'LONG' for column 'text'

# Could not dump table "mview$_adv_workload" because of following StandardError
#   Unknown type 'LONG' for column 'sql_text'

  create_table "nach_members", force: :cascade do |t|
    t.string "iin", limit: 50, null: false, comment: "the IIN of the bank"
    t.string "name", limit: 50, null: false, comment: "the name of the bank"
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.datetime "updated_at", null: false, comment: "the timestamp when the record was last updated"
    t.string "created_by", limit: 20, comment: "the person who creates the record"
    t.string "updated_by", limit: 20, comment: "the person who updates the record"
    t.integer "lock_version", precision: 38, default: 0, null: false, comment: "the version number of the record, every update increments this by 1"
    t.string "last_action", limit: 1, default: "C", null: false, comment: "the last action (create, update) that was performed on the record"
    t.string "approval_status", limit: 1, default: "U", null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
    t.integer "approved_version", precision: 38, comment: "the version number of the record, at the time it was approved"
    t.integer "approved_id", precision: 38, comment: "the id of the record that is being updated"
    t.string "is_enabled", limit: 1, default: "N", null: false, comment: "the flag which indicates whether this bank is enabled or not"
    t.index ["iin", "approval_status"], name: "nach_members_01", unique: true
  end

# Could not dump table "ol$" because of following StandardError
#   Unknown type 'LONG' for column 'sql_text'

  create_table "ol$hints", temporary: true, id: false, force: :cascade do |t|
    t.string "ol_name", limit: 128
    t.decimal "hint#"
    t.string "category", limit: 128
    t.decimal "hint_type"
    t.string "hint_text", limit: 512
    t.decimal "stage#"
    t.decimal "node#"
    t.string "table_name", limit: 128
    t.decimal "table_tin"
    t.decimal "table_pos"
    t.decimal "ref_id"
    t.string "user_table_name", limit: 260
    t.float "cost", limit: 126
    t.float "cardinality", limit: 126
    t.float "bytes", limit: 126
    t.decimal "hint_textoff"
    t.decimal "hint_textlen"
    t.string "join_pred", limit: 2000
    t.decimal "spare1"
    t.decimal "spare2"
    t.text "hint_string"
    t.index ["ol_name", "hint#"], name: "ol$hnt_num", unique: true
  end

  create_table "ol$nodes", temporary: true, id: false, force: :cascade do |t|
    t.string "ol_name", limit: 128
    t.string "category", limit: 128
    t.decimal "node_id"
    t.decimal "parent_id"
    t.decimal "node_type"
    t.decimal "node_textlen"
    t.decimal "node_textoff"
    t.string "node_name", limit: 64
  end

  create_table "partner_lcy_rates", force: :cascade do |t|
    t.string "partner_code", limit: 20, null: false, comment: "the code of the partner"
    t.integer "rate", precision: 38, comment: "the lcy rate for the partner"
    t.string "is_enabled", limit: 1, default: "Y", null: false, comment: "the indicator to specify if the guideline is enabled or not"
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.datetime "updated_at", null: false, comment: "the timestamp when the record was last updated"
    t.string "created_by", limit: 20, comment: "the person who creates the record"
    t.string "updated_by", limit: 20, comment: "the person who updates the record"
    t.integer "lock_version", precision: 38, default: 0, null: false, comment: "the version number of the record, every update increments this by 1"
    t.string "approval_status", limit: 1, default: "U", null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
    t.string "last_action", limit: 1, default: "C", null: false, comment: "the last action (create, update) that was performed on the record"
    t.integer "approved_version", precision: 38, comment: "the version number of the record, at the time it was approved"
    t.integer "approved_id", precision: 38, comment: "the id of the record that is being updated"
    t.index ["partner_code", "approval_status"], name: "partner_lcy_rates_01", unique: true
  end

  create_table "partners", force: :cascade do |t|
    t.string "code", limit: 20, null: false
    t.string "name", limit: 20, null: false
    t.string "tech_email_id"
    t.string "ops_email_id"
    t.string "account_no", limit: 20, null: false
    t.string "account_ifsc", limit: 20, null: false
    t.integer "txn_hold_period_days", precision: 38, default: 7, null: false
    t.string "identity_user_id", limit: 20
    t.integer "low_balance_alert_at", precision: 38
    t.string "remitter_sms_allowed", limit: 1
    t.string "remitter_email_allowed", limit: 1
    t.string "beneficiary_sms_allowed", limit: 1
    t.string "beneficiary_email_allowed", limit: 1
    t.string "allow_neft", limit: 1
    t.string "allow_rgts", limit: 1
    t.string "allow_imps", limit: 1
    t.string "created_by", limit: 20
    t.string "updated_by", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lock_version", precision: 38
    t.string "approval_status", limit: 1, default: "U", null: false
    t.string "last_action", limit: 1, default: "C"
    t.integer "approved_version", precision: 38
    t.integer "approved_id", precision: 38
    t.string "auto_reschdl_to_next_wrk_day", limit: 1, default: "Y", comment: "the identifier to specify if the transaction has to be rescheduled for the next working day instead of failing it."
    t.string "neft_limit_check"
    t.string "action_limit_breach"
    t.string "low_balannce_alert_at"
    t.string "enabled"
    t.string "customer_id"
    t.string "reply_with_bene_name"
    t.string "notify_on_status_change"
    t.string "app_code"
    t.string "allow_rtgs"
    t.string "add_req_ref_in_rep"
    t.string "add_transfer_amt_in_rep"
    t.string "n10_notification_enabled"
    t.string "notify_downtime"
    t.string "service_name"
    t.string "service_mid"
    t.string "sender_mid"
    t.string "receiver_mid"
    t.string "anchorid"
    t.string "liquity_provider_id"
    t.string "allow_upi"
    t.string "validate_vpa"
    t.string "merchant_id"
    t.string "will_whitelist"
    t.string "will_send_id"
    t.string "hold_for_whitelisting"
    t.string "auto_match_rule"
    t.string "mmid"
    t.string "mobile_no"
    t.string "address_line1"
    t.string "address_line2"
    t.string "address_line3"
    t.string "sender_rc", limit: 20, null: false
    t.string "working_day_limit"
    t.string "non_working_day_limit"
    t.string "guidelie_id"
    t.string "guideline_id"
    t.string "country"
    t.index ["code", "approval_status"], name: "partners_01", unique: true
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
    t.integer "attempt_no", precision: 38, comment: "the attempt number of the requery"
    t.index ["inward_remittance_id"], name: "index_pending_inward_remittances_on_inward_remittance_id", unique: true
  end

  create_table "post1s", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "name"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer "guideline_id", precision: 38, default: 1, null: false, comment: "the guidline for which this purpose code is allowed"
    t.index ["code", "approval_status"], name: "purpose_codes_01", unique: true
  end

  create_table "redo_db", id: false, force: :cascade do |t|
    t.decimal "dbid", null: false
    t.string "global_dbname", limit: 129
    t.string "dbuname", limit: 32
    t.string "version", limit: 32
    t.decimal "thread#", null: false
    t.decimal "resetlogs_scn_bas"
    t.decimal "resetlogs_scn_wrp"
    t.decimal "resetlogs_time", null: false
    t.decimal "presetlogs_scn_bas"
    t.decimal "presetlogs_scn_wrp"
    t.decimal "presetlogs_time", null: false
    t.decimal "seqno_rcv_cur"
    t.decimal "seqno_rcv_lo"
    t.decimal "seqno_rcv_hi"
    t.decimal "seqno_done_cur"
    t.decimal "seqno_done_lo"
    t.decimal "seqno_done_hi"
    t.decimal "gap_seqno"
    t.decimal "gap_ret"
    t.decimal "gap_done"
    t.decimal "apply_seqno"
    t.decimal "apply_done"
    t.decimal "purge_done"
    t.decimal "has_child"
    t.decimal "error1"
    t.decimal "status"
    t.date "create_date"
    t.decimal "ts1"
    t.decimal "ts2"
    t.decimal "gap_next_scn"
    t.decimal "gap_next_time"
    t.decimal "curscn_time"
    t.decimal "resetlogs_scn", null: false
    t.decimal "presetlogs_scn", null: false
    t.decimal "gap_ret2"
    t.decimal "curlog"
    t.decimal "endian"
    t.decimal "enqidx"
    t.decimal "spare4"
    t.date "spare5"
    t.string "spare6", limit: 65
    t.string "spare7", limit: 129
    t.decimal "ts3"
    t.decimal "curblkno"
    t.decimal "spare8"
    t.decimal "spare9"
    t.decimal "spare10"
    t.decimal "spare11"
    t.decimal "spare12"
    t.decimal "tenant_key", null: false
    t.index ["tenant_key", "dbid", "thread#", "resetlogs_scn", "resetlogs_time"], name: "redo_db_idx", tablespace: "sysaux"
  end

  create_table "redo_log", id: false, force: :cascade do |t|
    t.decimal "dbid", null: false
    t.string "global_dbname", limit: 129
    t.string "dbuname", limit: 32
    t.string "version", limit: 32
    t.decimal "thread#", null: false
    t.decimal "resetlogs_scn_bas"
    t.decimal "resetlogs_scn_wrp"
    t.decimal "resetlogs_time", null: false
    t.decimal "presetlogs_scn_bas"
    t.decimal "presetlogs_scn_wrp"
    t.decimal "presetlogs_time", null: false
    t.decimal "sequence#", null: false
    t.decimal "dupid"
    t.decimal "status1"
    t.decimal "status2"
    t.string "create_time", limit: 32
    t.string "close_time", limit: 32
    t.string "done_time", limit: 32
    t.decimal "first_scn_bas"
    t.decimal "first_scn_wrp"
    t.decimal "first_time"
    t.decimal "next_scn_bas"
    t.decimal "next_scn_wrp"
    t.decimal "next_time"
    t.decimal "first_scn"
    t.decimal "next_scn"
    t.decimal "resetlogs_scn", null: false
    t.decimal "blocks"
    t.decimal "block_size"
    t.decimal "old_blocks"
    t.date "create_date"
    t.decimal "error1"
    t.decimal "error2"
    t.string "filename", limit: 513
    t.decimal "ts1"
    t.decimal "ts2"
    t.decimal "endian"
    t.decimal "spare2"
    t.decimal "spare3"
    t.decimal "spare4"
    t.date "spare5"
    t.string "spare6", limit: 65
    t.string "spare7", limit: 129
    t.decimal "ts3"
    t.decimal "presetlogs_scn", null: false
    t.decimal "spare8"
    t.decimal "spare9"
    t.decimal "spare10"
    t.decimal "old_status1"
    t.decimal "old_status2"
    t.string "old_filename", limit: 513
    t.decimal "tenant_key", null: false
    t.index ["tenant_key", "dbid", "thread#", "resetlogs_scn", "resetlogs_time"], name: "redo_log_idx", tablespace: "sysaux"
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

  create_table "sc_backend_response_codes", force: :cascade do |t|
    t.string "is_enabled", limit: 1, null: false, comment: "the flag which indicates whether this record is enabled or not"
    t.string "sc_backend_code", limit: 20, null: false, comment: "the code assigned to the backend"
    t.string "response_code", limit: 50, null: false, comment: "the response code sent by the backend"
    t.string "fault_code", limit: 50, null: false, comment: "the fault code used for the backend response code"
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.datetime "updated_at", null: false, comment: "the timestamp when the record was last updated"
    t.string "created_by", limit: 20, comment: "the person who creates the record"
    t.string "updated_by", limit: 20, comment: "the person who updates the record"
    t.integer "lock_version", precision: 38, default: 0, null: false, comment: "the version number of the record, every update increments this by 1"
    t.string "approval_status", limit: 1, default: "U", null: false, comment: "the approval status of the record, A (approved), U (unapproved)"
    t.string "last_action", limit: 1, default: "C", comment: "the last action on the record, C (create), U (update), D (delete)"
    t.integer "approved_id", precision: 38, comment: "the id of the approved record that was edited, and resulted in this unapproved record "
    t.integer "approved_version", precision: 38, comment: "the lock_version of the approved record at the time it was edited, and resulted in this unapproved record"
    t.index ["sc_backend_code", "response_code", "approval_status"], name: "sc_backend_response_codes_01", unique: true
  end

  create_table "sc_backend_settings", force: :cascade do |t|
    t.string "backend_code", limit: 50, null: false, comment: "the backend code for the setting"
    t.string "service_code", limit: 50, null: false, comment: "the service code for the setting"
    t.string "app_id", limit: 50, comment: "the app_id for the setting"
    t.integer "settings_cnt", precision: 38, comment: "the count of settings for this setting"
    t.string "setting1", comment: "the setting 1 for the setting"
    t.string "setting2", comment: "the setting 2 for the setting"
    t.string "setting3", comment: "the setting 3 for the setting"
    t.string "setting4", comment: "the setting 4 for the setting"
    t.string "setting5", comment: "the setting 5 for the setting"
    t.string "setting6", comment: "the setting 6 for the setting"
    t.string "setting7", comment: "the setting 7 for the setting"
    t.string "setting8", comment: "the setting 8 for the setting"
    t.string "setting9", comment: "the setting 9 for the setting"
    t.string "setting10", comment: "the setting 10 for the setting"
    t.datetime "created_at", null: false, comment: "the timestamp when the record was created"
    t.datetime "updated_at", null: false, comment: "the timestamp when the record was last updated"
    t.string "created_by", limit: 20, comment: "the person who creates the record"
    t.string "updated_by", limit: 20, comment: "the person who updates the record"
    t.integer "lock_version", precision: 38, default: 0, null: false, comment: "the version number of the record, every update increments this by 1"
    t.string "last_action", limit: 1, default: "C", null: false, comment: "the last action (create, update) that was performed on the record"
    t.string "approval_status", limit: 1, default: "U", null: false, comment: "the indicator to denote whether this record is pending approval or is approved"
    t.integer "approved_version", precision: 38, comment: "the version number of the record, at the time it was approved"
    t.integer "approved_id", precision: 38, comment: "the id of the record that is being updated"
    t.string "is_std", limit: 1, default: "N", null: false, comment: "the flag which indicates whether the setting is std or not"
    t.string "is_enabled", limit: 1, default: "N", null: false, comment: "the flag which indicates whether the setting is enabled or not"
    t.index ["backend_code", "service_code", "app_id", "approval_status"], name: "sc_backend_settings_01", unique: true
  end

# Could not dump table "scheduler_job_args_tbl" because of following StandardError
#   Unknown type 'SYS.ANYDATA' for column 'anydata_value'

# Could not dump table "scheduler_program_args_tbl" because of following StandardError
#   Unknown type 'SYS.ANYDATA' for column 'default_anydata_value'

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
    t.string "notify_app_code", limit: 20, comment: "the application code which has to be used to send a notification"
    t.string "notify_on_status_change", limit: 1, default: "N", null: false, comment: "the indicator which represent whether the notification has to be sent or not"
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

  create_table "sm_payments", force: :cascade do |t|
    t.string "req_no", limit: 20, comment: "the Unique request no for the transaction "
    t.string "req_version", limit: 10, comment: "the request version for the transaction"
    t.datetime "req_timestamp", comment: "the Time at which the request was received"
    t.string "partner_code", limit: 20, comment: "the unique code assigned to the sub member bank"
    t.string "customer_id", limit: 15, comment: "the customer ID assigned to the partner in the CBS. Multiple customer ids can be assigned to a single partner."
    t.string "debit_account_no", limit: 20, comment: "the account to be debited. This account should be belong to the customerID that is passed in the request."
    t.string "rmtr_account_no", limit: 20, comment: "the remitters account no, as maintained in the partner system."
    t.string "rmtr_account_ifsc", limit: 50, comment: "the IFSC of the remitters account, as maintained in the partner system"
    t.string "rmtr_full_name", limit: 100, comment: "the full name of the remitter"
    t.string "rmtr_address1", comment: "the address1 of the remitter"
    t.string "rmtr_address2", comment: "the address2 of the remitter"
    t.string "rmtr_address3", comment: "the address3 of the remitter"
    t.string "rmtr_postal_code", limit: 10, comment: "the postal code of the remitter"
    t.string "rmtr_city", limit: 100, comment: "the city name of the remitter"
    t.string "rmtr_state", limit: 100, comment: "the state name of the remitter"
    t.string "rmtr_country", limit: 100, comment: "the country name of the remitter"
    t.string "rmtr_mobile_no", limit: 10, comment: "the mobile no of the remitter"
    t.string "rmtr_email_id", limit: 100, comment: " the email id of the remitter"
    t.string "bene_full_name", limit: 100, comment: "the full name of the beneficiary"
    t.string "bene_address1", comment: "the address1 of the beneficiary"
    t.string "bene_address2", comment: "the address2 of the beneficiary"
    t.string "bene_address3", comment: "the address3 of the beneficiary"
    t.string "bene_postal_code", limit: 100, comment: "the postal code of the beneficiary"
    t.string "bene_city", limit: 100, comment: "the city name of the beneficiary"
    t.string "bene_state", limit: 100, comment: "the state name of the beneficiary"
    t.string "bene_country", limit: 100, comment: "the country name of the beneficiary"
    t.string "bene_mobile_no", limit: 10, comment: "the mobile no of the beneficiary"
    t.string "bene_email_id", limit: 100, comment: " the email id of the beneficiary"
    t.string "bene_account_no", limit: 20, comment: "the beneficiary account number"
    t.string "bene_account_ifsc", limit: 50, comment: "the ifsc code of the beneficiary account"
    t.string "req_transfer_type", limit: 4, comment: "the requested transfer type, the one use can be different"
    t.string "transfer_ccy", limit: 5, comment: "the transfer amounts currency"
    t.integer "transfer_amount", precision: 38, comment: "the transfer amount"
    t.string "rmtr_to_bene_note", comment: "the narrative for transaction of remitter to beneficiary"
    t.string "rep_version", limit: 20, comment: "the number comes in the reply, this reflects the version that is known to the server"
    t.string "rep_no", limit: 10, comment: "the unique response no sent by API"
    t.integer "attempt_no", precision: 38, comment: "the attempt no returned in the response by the api"
    t.string "transfer_type", limit: 4, comment: "the transfer type, that was used by the service"
    t.string "status_code", limit: 50, comment: "the status of the transaction"
    t.string "bank_ref_no", limit: 50, comment: "the reference number generated by the bank, and passed on to the payment network"
    t.string "fault_code", limit: 50, comment: "the code that identifies the exception, if an exception occured in the ESB"
    t.string "fault_subcode", limit: 50, comment: "the error code that the third party will return"
    t.string "fault_reason", limit: 1000, comment: "the english reason of the exception, if an exception occurred in the ESB"
    t.datetime "rep_timestamp", comment: "the Time at which the response was received"
    t.index ["req_no", "attempt_no"], name: "sm_payments_01", unique: true
  end

# Could not dump table "sqlplus_product_profile" because of following StandardError
#   Unknown type 'LONG' for column 'long_value'

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "stream"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "su_customers", force: :cascade do |t|
    t.string "account_no", limit: 20, comment: "the debit account no of the corporate, duplicate entries are not allowed"
    t.string "customer_id", limit: 15, comment: "the customer id of the corporate, duplicate entries are not allowed"
    t.string "pool_account_no", limit: 20, comment: "the pool account no for the corporate, multiple corporates can share a pool account"
    t.string "pool_customer_id", limit: 20, comment: "the customer id for the pool account"
    t.string "is_enabled", limit: 1, comment: "the flag to decide if the account is enabled or not "
    t.string "created_by", limit: 20, comment: "the person who creates the record"
    t.string "updated_by", limit: 20, comment: "the person who updates the record"
    t.datetime "created_at", comment: "the timestamp when the file was created"
    t.datetime "updated_at", comment: "the timestamp when the record was last updated"
    t.integer "lock_version", precision: 38, default: 0, comment: "the version number of the record every update increments this by 1"
    t.string "approval_status", limit: 1, default: "U", comment: "the indicator to denote whether this record is pending approval or is approved"
    t.string "last_action", limit: 1, default: "C", comment: "the last action create or update that was performed on the record"
    t.integer "approved_version", precision: 38, comment: "the version number of the record at the time it was approved"
    t.integer "approved_id", precision: 38, comment: "the id of the record that is being updated"
    t.string "customer_name", limit: 100, comment: "the name of the customer"
    t.decimal "max_distance_for_name"
    t.string "ops_email"
    t.string "rm_email"
    t.index ["customer_id", "account_no", "approval_status"], name: "uk_su_customers_1", unique: true
  end

  create_table "udf_attributes", force: :cascade do |t|
    t.string "class_name", limit: 100, null: false
    t.string "attribute_name", limit: 100, null: false
    t.string "label_text", limit: 100, null: false
    t.string "is_enabled", limit: 1, default: "Y", null: false
    t.string "is_mandatory", limit: 1, default: "N", null: false
    t.string "control_type"
    t.string "data_type"
    t.text "constraints"
    t.text "select_options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "created_by", limit: 20
    t.string "updated_by", limit: 20
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
    t.string "unique_session_id"
    t.string "first_name"
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
    t.string "bene_account_no", limit: 30, comment: "the account number of the beneficiary to which the identity belongs"
    t.string "bene_account_ifsc", limit: 15, comment: "the account ifsc code of the beneficiary to which the identity belongs"
    t.string "rmtr_code", limit: 50, comment: "the partner assigned code of the remitter to which the identity belongs"
    t.integer "created_for_txn_id", precision: 38, comment: "the transaction for which this whitelisted identity was created"
    t.index ["last_used_with_txn_id"], name: "index_whitelisted_identities_on_last_used_with_txn_id"
  end

  add_foreign_key "mview$_adv_ajg", "mview$_adv_log", column: "runid#", primary_key: "runid#", name: "mview$_adv_ajg_fk"
  add_foreign_key "mview$_adv_basetable", "mview$_adv_workload", column: "queryid#", primary_key: "queryid#", name: "mview$_adv_basetable_fk"
  add_foreign_key "mview$_adv_clique", "mview$_adv_log", column: "runid#", primary_key: "runid#", name: "mview$_adv_clique_fk"
  add_foreign_key "mview$_adv_eligible", "mview$_adv_log", column: "runid#", primary_key: "runid#", name: "mview$_adv_eligible_fk"
  add_foreign_key "mview$_adv_exceptions", "mview$_adv_log", column: "runid#", primary_key: "runid#", name: "mview$_adv_exception_fk"
  add_foreign_key "mview$_adv_filterinstance", "mview$_adv_log", column: "runid#", primary_key: "runid#", name: "mview$_adv_filterinstance_fk"
  add_foreign_key "mview$_adv_fjg", "mview$_adv_ajg", column: "ajgid#", primary_key: "ajgid#", name: "mview$_adv_fjg_fk"
  add_foreign_key "mview$_adv_gc", "mview$_adv_fjg", column: "fjgid#", primary_key: "fjgid#", name: "mview$_adv_gc_fk"
  add_foreign_key "mview$_adv_info", "mview$_adv_log", column: "runid#", primary_key: "runid#", name: "mview$_adv_info_fk"
  add_foreign_key "mview$_adv_journal", "mview$_adv_log", column: "runid#", primary_key: "runid#", name: "mview$_adv_journal_fk"
  add_foreign_key "mview$_adv_level", "mview$_adv_log", column: "runid#", primary_key: "runid#", name: "mview$_adv_level_fk"
  add_foreign_key "mview$_adv_output", "mview$_adv_log", column: "runid#", primary_key: "runid#", name: "mview$_adv_output_fk"
  add_foreign_key "mview$_adv_rollup", "mview$_adv_level", column: "clevelid#", primary_key: "levelid#", name: "mview$_adv_rollup_cfk"
  add_foreign_key "mview$_adv_rollup", "mview$_adv_level", column: "plevelid#", primary_key: "levelid#", name: "mview$_adv_rollup_pfk"
  add_foreign_key "mview$_adv_rollup", "mview$_adv_level", column: "runid#", primary_key: "runid#", name: "mview$_adv_rollup_cfk"
  add_foreign_key "mview$_adv_rollup", "mview$_adv_level", column: "runid#", primary_key: "runid#", name: "mview$_adv_rollup_pfk"
  add_foreign_key "mview$_adv_rollup", "mview$_adv_log", column: "runid#", primary_key: "runid#", name: "mview$_adv_rollup_fk"
  add_synonym "syscatalog", "sys.syscatalog", force: true
  add_synonym "catalog", "sys.catalog", force: true
  add_synonym "tab", "sys.tab", force: true
  add_synonym "col", "sys.col", force: true
  add_synonym "tabquotas", "sys.tabquotas", force: true
  add_synonym "sysfiles", "sys.sysfiles", force: true
  add_synonym "publicsyn", "sys.publicsyn", force: true
  add_synonym "aq$_queue_tables", "sys.aq$_queue_tables", force: true
  add_synonym "aq$_queues", "sys.aq$_queues", force: true
  add_synonym "aq$_key_shard_map", "sys.aq$_key_shard_map", force: true
  add_synonym "aq$_internet_agents", "sys.aq$_internet_agents", force: true
  add_synonym "aq$_internet_agent_privs", "sys.aq$_internet_agent_privs", force: true
  add_synonym "product_user_profile", "system.sqlplus_product_profile", force: true

end
