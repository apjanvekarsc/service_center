module FtIncomingRecordsHelper
  def find_ft_incoming_records(params,records)
    incoming_records = records
    incoming_records = incoming_records.where("overrides is not null") if params[:overrided_flag].present? and params[:overrided_flag] == "true"
    incoming_records = incoming_records.where("overrides is null") if params[:overrided_flag].present? and params[:overrided_flag] == "false"
    incoming_records = incoming_records.where("ft_incoming_records.req_no=?",params[:req_no]) if params[:req_no].present?
    incoming_records = incoming_records.where("ft_incoming_records.bank_ref_no=?",params[:bank_ref_no]) if params[:bank_ref_no].present?
    incoming_records = incoming_records.where("ft_incoming_records.debit_account_no=?",params[:debit_account_no]) if params[:debit_account_no].present?
    incoming_records = incoming_records.where("ft_incoming_records.bene_account_no=?",params[:bene_account_no]) if params[:bene_account_no].present?
    incoming_records = incoming_records.where("ft_incoming_records.req_transfer_type=?",params[:req_transfer_type]) if params[:req_transfer_type].present?
    incoming_records = incoming_records.where("ft_incoming_records.transfer_type=?",params[:transfer_type]) if params[:transfer_type].present?
    incoming_records = incoming_records.where("ft_incoming_records.transfer_amount >=?",params[:from_amount].to_f) if params[:from_amount].present?
    incoming_records = incoming_records.where("ft_incoming_records.transfer_amount <=?",params[:to_amount].to_f) if params[:to_amount].present? 
    incoming_records
  end
end