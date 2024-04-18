module PcIncomingRecordsHelper
  def find_pc_incoming_records(params,records)
    incoming_records = records
    incoming_records = incoming_records.where("overrides is not null") if params[:overrided_flag].present? and params[:overrided_flag] == "true"
    incoming_records = incoming_records.where("overrides is null") if params[:overrided_flag].present? and params[:overrided_flag] == "false"
    incoming_records = incoming_records.where("pc_mm_cd_incoming_records.req_reference_no=?",params[:req_no]) if params[:req_no].present?
    incoming_records = incoming_records.where("pc_mm_cd_incoming_records.rep_reference_no=?",params[:rep_no]) if params[:rep_no].present?
    incoming_records = incoming_records.where("pc_mm_cd_incoming_records.transfer_amount >=?",params[:from_amount].to_f) if params[:from_amount].present?
    incoming_records = incoming_records.where("pc_mm_cd_incoming_records.transfer_amount <=?",params[:to_amount].to_f) if params[:to_amount].present? 
    incoming_records
  end
end