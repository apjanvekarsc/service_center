class IamCustUserSearcher
  include ActiveModel::Validations
  attr_accessor :page, :username, :email,:secondary_email, :mobile_no,:secondary_mobile_no, :approval_status
  PER_PAGE = 10
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def paginate
    if valid? 
      find.paginate(per_page: PER_PAGE, page: page)
    else
      IamCustUser.none.paginate(per_page: PER_PAGE, page: page)
    end
  end

  private  
  def persisted?
    false
  end
# ft_customer_accounts.where("customer_id IN (?)",params[:customer_id].split(",").collect(&:strip)) if params[:customer_id].present?
    
  def find
    reln = approval_status == 'U' ? IamCustUser.unscoped.where("approval_status =?",'U').order("id desc") : IamCustUser.order("id desc")
    reln = reln.where("username IN (?)", username.split(",").collect(&:strip)) if username.present?
    reln = reln.where("email IN (?)", email.split(",").collect(&:strip)) if email.present?
    reln = reln.where("secondary_email IN (?)", secondary_email.split(",").collect(&:strip)) if secondary_email.present?
    reln = reln.where("mobile_no IN (?)", mobile_no.split(",").collect(&:strip)) if mobile_no.present?
    reln = reln.where("secondary_mobile_no IN (?)", secondary_mobile_no.split(",").collect(&:strip)) if secondary_mobile_no.present?
    reln
  end
end