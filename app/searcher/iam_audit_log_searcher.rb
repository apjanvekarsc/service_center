class IamAuditLogSearcher
  include ActiveModel::Validations
  attr_accessor :page, :org_uuid, :cert_dn, :source_ip
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
      IamAuditLog.none.paginate(per_page: PER_PAGE, page: page)
    end
  end
  
  private  
    def persisted?
      false
    end
    
    def find
      reln = IamAuditLog.order("id desc")
      reln = reln.where("org_uuid IN (?)", org_uuid.split(",").collect(&:strip)) if org_uuid.present?
      reln = reln.where("cert_dn IN (?)", cert_dn.split(",").collect(&:strip)) if cert_dn.present?
      reln = reln.where("source_ip IN (?)", source_ip.split(",").collect(&:strip)) if source_ip.present?
      reln
    end
end