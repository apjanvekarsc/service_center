class FrR01IncomingRecordSearcher
  attr_accessor :page, :account_no, :customer_name, :status, :file_name, :overrided_flag
  PER_PAGE = 10

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def paginate
    find.paginate(per_page: PER_PAGE, page: page)
  end

  private
  def persisted?
    false
  end

  def find
    reln = FrR01IncomingRecord.joins(:incoming_file_record).where("fr_r01_incoming_records.file_name=? and status=?",file_name,status).order("fr_r01_incoming_records.id desc")
    reln = reln.where("incoming_file_records.overrides is not null") if overrided_flag.present? and overrided_flag == "true"
    reln = reln.where("incoming_file_records.overrides is null") if overrided_flag.present? and overrided_flag == "false"
    reln = reln.where("fr_r01_incoming_records.customer_name like ?","#{customer_name}%") if customer_name.present?
    reln = reln.where("fr_r01_incoming_records.account_no like ?","#{account_no}%") if account_no.present?
    reln
  end
end