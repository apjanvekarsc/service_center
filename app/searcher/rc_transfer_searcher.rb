class RcTransferSearcher
  include ActiveModel::Validations
  attr_accessor :page, :rc_code, :bene_account_no, :debit_account_no, :from_amount, :to_amount, :status, :notify_status, :mobile_no, :pending_approval, :transfer_rep_ref, :remove_defaults     
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
      RcTransfer.none.paginate(per_page: PER_PAGE, page: page)
    end
  end

  private  
  def persisted?
    false
  end

  def find
    reln = RcTransfer.order("id desc")
    reln = reln.where.not("status_code IN ('BALINQ FAILED','SKIP CREDIT:NO BALANCE')") unless remove_defaults.present?
    reln = reln.where("rc_transfer_code IN (?)", rc_code.split(",").collect(&:strip)) if rc_code.present?
    reln = reln.where("bene_account_no IN (?)", bene_account_no.split(",").collect(&:strip)) if bene_account_no.present?
    reln = reln.where("debit_account_no IN (?)", debit_account_no.split(",").collect(&:strip)) if debit_account_no.present?
    reln = reln.where("transfer_rep_ref IN (?)", transfer_rep_ref.split(",").collect(&:strip)) if transfer_rep_ref.present?
    reln = reln.where("transfer_amount>=? and transfer_amount <=?",from_amount.to_f,to_amount.to_f) if to_amount.present? && from_amount.present?
    reln = reln.where("status_code=?",status) if status.present?
    reln = reln.where("notify_status=?",notify_status) if notify_status.present?
    reln = reln.where("mobile_no=?", mobile_no) if mobile_no.present?
    reln = reln.where("pending_approval=?", pending_approval) if pending_approval.present?
    reln
  end
end