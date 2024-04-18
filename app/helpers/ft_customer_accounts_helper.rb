module FtCustomerAccountsHelper
  def find_ft_customer_accounts(params)
    ft_customer_accounts = (params[:approval_status].present? and params[:approval_status] == 'U') ? FtCustomerAccount.unscope : FtCustomerAccount
    ft_customer_accounts = ft_customer_accounts.where("customer_id IN (?)",params[:customer_id].split(",").collect(&:strip)) if params[:customer_id].present?
    ft_customer_accounts
  end
end
