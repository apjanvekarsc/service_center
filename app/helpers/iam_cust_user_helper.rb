module IamCustUserHelper

	def find_iam_cust_users(params)
    iam_cust_users = (params[:approval_status].present? and params[:approval_status] == 'U') ? IamCustUser.unscope : IamCustUser
    iam_cust_users = iam_cust_users.where("username IN (?)", params[:username].split(",").collect(&:strip)) if params[:username].present?
    iam_cust_users = iam_cust_users.where("email IN (?)", params[:email].split(",").collect(&:strip)) if params[:email].present?
    iam_cust_users = iam_cust_users.where("secondary_email IN (?)", params[:secondary_email].split(",").collect(&:strip)) if params[:secondary_email].present?
    iam_cust_users = iam_cust_users.where("mobile_no IN (?)", params[:mobile_no].split(",").collect(&:strip)) if params[:mobile_no].present?
    iam_cust_users = iam_cust_users.where("secondary_mobile_no IN (?)", params[:secondary_mobile_no].split(",").collect(&:strip)) if params[:secondary_mobile_no].present?
    iam_cust_users
  end

end