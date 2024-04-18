module RrIncomingRecordsHelper
  def find_rr_incoming_records(params,records)
    incoming_records = records
    incoming_records = incoming_records.where("overrides is not null") if params[:overrided_flag].present? and params[:overrided_flag] == "true"
    incoming_records = incoming_records.where("overrides is null") if params[:overrided_flag].present? and params[:overrided_flag] == "false"
    incoming_records = incoming_records.where("rr_incoming_records.txn_type=?",params[:txn_type]) if params[:txn_type].present?
    incoming_records = incoming_records.where("rr_incoming_records.bank_ref_no=?",params[:bank_ref_no]) if params[:bank_ref_no].present?
    incoming_records
  end
end