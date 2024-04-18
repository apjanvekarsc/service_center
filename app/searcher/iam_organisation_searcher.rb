class IamOrganisationSearcher
  include ActiveModel::Validations
  attr_accessor :page, :name, :org_uuid, :approval_status
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
      IamOrganisation.none.paginate(per_page: PER_PAGE, page: page)
    end
  end

  private  
  def persisted?
    false
  end

  def find
    reln = approval_status == 'U' ? IamOrganisation.unscoped.where("approval_status =?",'U').order("id desc") : IamOrganisation.order("id desc")
    reln = reln.where("name IN (?)", name.split(",").collect(&:strip)) if name.present?
    reln = reln.where("org_uuid IN (?)", org_uuid.split(",").collect(&:strip)) if org_uuid.present?
    reln
  end
end