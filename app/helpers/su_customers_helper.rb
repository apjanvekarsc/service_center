module SuCustomersHelper
  def find_su_customers(params)
    su_customers = (params[:approval_status].present? and params[:approval_status] == 'U') ? SuCustomer.unscope : SuCustomer
    su_customers = su_customers.where("account_no=?",params[:account_no]) if params[:account_no].present?
    su_customers = su_customers.where("customer_id=?",params[:customer_id]) if params[:customer_id].present?
    su_customers = su_customers.where("pool_account_no=?",params[:pool_account_no]) if params[:pool_account_no].present?
    su_customers = su_customers.where("pool_customer_id=?",params[:pool_customer_id]) if params[:pool_customer_id].present?
    su_customers
  end
end
