module CnIncomingRecordsHelper
  def find_cn_incoming_records(params,records)
    incoming_records = records
    incoming_records = incoming_records.where("overrides is not null") if params[:overrided_flag].present? and params[:overrided_flag] == "true"
    incoming_records = incoming_records.where("overrides is null") if params[:overrided_flag].present? and params[:overrided_flag] == "false"
    incoming_records = incoming_records.where("cn_incoming_records.debit_account_no=?",params[:debit_account_no]) if params[:debit_account_no].present?
    incoming_records = incoming_records.where("cn_incoming_records.bene_account_no=?",params[:bene_account_no]) if params[:bene_account_no].present?
    incoming_records = incoming_records.where("cn_incoming_records.transaction_ref_no=?",params[:ref_no]) if params[:ref_no].present?
    incoming_records = incoming_records.where("cn_incoming_records.amount >=?",params[:from_amount].to_f) if params[:from_amount].present?
    incoming_records = incoming_records.where("cn_incoming_records.amount <=?",params[:to_amount].to_f) if params[:to_amount].present? 
    incoming_records
  end
end