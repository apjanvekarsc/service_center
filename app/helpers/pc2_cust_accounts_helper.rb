module Pc2CustAccountsHelper
  def find_pc2_cust_accounts(params)
    pc2_cust_accounts = (params[:approval_status].present? and params[:approval_status] == 'U') ? Pc2CustAccount.unscope : Pc2CustAccount
    pc2_cust_accounts = pc2_cust_accounts.where("customer_id IN (?)",params[:customer_id].split(",").collect(&:strip)) if params[:customer_id].present?
    pc2_cust_accounts
  end
end
