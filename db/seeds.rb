# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if AdminUser.all.empty?
  admin = AdminUser.new(username: "admin1", email: "admin@example.com", password: "rootpassword",
                        password_confirmation: "rootpassword")
  if admin.save
    admin.add_role :super_admin
  end
end

AdminRole.create(:name => 'approver_admin') if AdminRole.find_by_name("approver_admin").nil?

Role.create(:name => "user") if Role.find_by_name("user").nil?
Role.create(:name => "editor") if Role.find_by_name("editor").nil?
Role.create(:name => "supervisor") if Role.find_by_name("supervisor").nil?
Role.create(:name => "tester") if Role.find_by_name("tester").nil?

Group.create(:name => "inward-remittance") if Group.find_by_name("inward-remittance").nil?
Group.create(:name => "e-collect") if Group.find_by_name("e-collect").nil?
Group.create(:name => "bill-management") if Group.find_by_name("bill-management").nil?
Group.create(:name => "prepaid-card") if Group.find_by_name("prepaid-card").nil?
Group.create(:name => "flex-proxy") if Group.find_by_name("flex-proxy").nil?
Group.create(:name => "imt") if Group.find_by_name("imt").nil?
Group.create(:name => "funds-transfer") if Group.find_by_name("funds-transfer").nil?
Group.create(:name => "salary-upload") if Group.find_by_name("salary-upload").nil?

unless Rails.env == 'production'
  if InwRemittanceRule.all.empty?
    InwRemittanceRule.create!(:pattern_salutations => "Mr\r\nMrs\r\nMiss\r\nDr\r\nMs\r\nPRof\r\nRev\r\nLady\r\nSir\r\nCapt\r\nMajor\r\nLtCol\r\nCol", :approval_status => 'A')
  end

  if EcolRule.all.empty?
    EcolRule.create(:ifsc => "QGPL0123456", :cod_acct_no => "0123456789", :stl_gl_inward => "123456789", :approval_status => 'A',
                    :neft_sender_ifsc => "ABCD0123456", :customer_id => "QWEASD")
  end

  if BmRule.all.empty?
    BmRule.create(:cod_acct_no => "0123456789", :customer_id => "QWEASD", :bene_acct_no => "0123456788", :bene_account_ifsc => "IFSC0123456", :neft_sender_ifsc => 'IFSC0123456', :approval_status => 'A', :service_id => 'NETUSER')
  end
  
  if FpOperation.all.empty? 
    FpOperation.create(:operation_name => 'validateCustomer', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireCustomerAccount', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireCASAMiniListOfTransaction', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireCasaAccountBalance', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireCASAStatementRequest', :approval_status => 'A')
    FpOperation.create(:operation_name => 'requestChequeBook', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireCASAChequeStatus', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireTDAccounts', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireTDBalanceDetails', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireTDBalanceDetailsForDeposit', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireStopChequeDetails', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireStopChequeSeries', :approval_status => 'A')
    FpOperation.create(:operation_name => 'fundsXferCASAToCASA', :approval_status => 'A')
    FpOperation.create(:operation_name => 'fundsXferNEFT', :approval_status => 'A')
    FpOperation.create(:operation_name => 'userLogin', :approval_status => 'A')
    FpOperation.create(:operation_name => 'beneficiaryLibrary', :approval_status => 'A')
    FpOperation.create(:operation_name => 'beneficiarySearch', :approval_status => 'A')
    FpOperation.create(:operation_name => 'holdRequestForASBA', :approval_status => 'A')
    FpOperation.create(:operation_name => 'deleteEarmarkASBA', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireCasaTdAccountBalance', :approval_status => 'A')
    FpOperation.create(:operation_name => 'modifyEarmarkASBA', :approval_status => 'A')
    FpOperation.create(:operation_name => 'custAsbaSignVerification', :approval_status => 'A')
    FpOperation.create(:operation_name => 'FCDBUserPBKDF2RetailCheck', :approval_status => 'A')
    FpOperation.create(:operation_name => 'FCDBUserPBKDF2CorpCheck', :approval_status => 'A')
    FpOperation.create(:operation_name => 'fundsXferNEFT', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireTransactionStatus', :approval_status => 'A')
    FpOperation.create(:operation_name => 'holdFundInquiry', :approval_status => 'A')
    FpOperation.create(:operation_name => 'partialEarmarkFunds', :approval_status => 'A')
    FpOperation.create(:operation_name => 'deleteEarmark', :approval_status => 'A')
    FpOperation.create(:operation_name => 'miscCustomerCredit', :approval_status => 'A')
    FpOperation.create(:operation_name => 'custSignVerification', :approval_status => 'A')
    FpOperation.create(:operation_name => 'fundsXferFCATRTGS', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireBranchDetails', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireTDRDProducts', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireTDProductRates', :approval_status => 'A')
    FpOperation.create(:operation_name => 'tdAccountOpeningPayin', :approval_status => 'A')
    FpOperation.create(:operation_name => 'tdSetPayoutInstruction', :approval_status => 'A')
    FpOperation.create(:operation_name => 'maintainSweepIn', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireRDProductRates', :approval_status => 'A')
    FpOperation.create(:operation_name => 'rdAccountOpeningPayin', :approval_status => 'A')
    FpOperation.create(:operation_name => 'inquireInstallmentPayment', :approval_status => 'A')
    FpOperation.create(:operation_name => 'glToGlFundsXfer', :approval_status => 'A')
  end
end# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')