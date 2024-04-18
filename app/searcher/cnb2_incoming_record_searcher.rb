class Cnb2IncomingRecordSearcher
  attr_accessor :page, :pay_comp_code, :vendor_code, :bene_account_no, :status, :file_name, :overrided_flag
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
    reln = Cnb2IncomingRecord.joins(:incoming_file_record).where("cnb2_incoming_records.file_name=? and status=?",file_name,status).order("cnb2_incoming_records.id desc")
    reln = reln.where("incoming_file_records.overrides is not null") if overrided_flag.present? and overrided_flag == "true"
    reln = reln.where("incoming_file_records.overrides is null") if overrided_flag.present? and overrided_flag == "false"
    reln = reln.where("cnb2_incoming_records.pay_comp_code like ?","#{pay_comp_code}%") if pay_comp_code.present?
    reln = reln.where("cnb2_incoming_records.vendor_code like ?","#{vendor_code}%") if vendor_code.present?
    reln = reln.where("cnb2_incoming_records.bene_account_no like ?","#{bene_account_no}%") if bene_account_no.present?
    reln
  end
end