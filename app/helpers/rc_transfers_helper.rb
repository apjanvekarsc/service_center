module RcTransfersHelper
  def find_logs(params,record)
    if params[:step_name] != 'ALL'
      record.rc_audit_steps.where('step_name=?',params[:step_name]).order("attempt_no desc") rescue []
    else
      record.rc_audit_steps.order("id desc") rescue []
    end      
  end

  def allow_retry(record)
    if (record.max_retries > 0 && ((record.attempt_no % record.max_retries) == 0) && (record.batch_no == record.rc_transfer_schedule.try(:last_batch_no)) && (['CREDIT FAILED','BALINQ FAILED'].include?(record.status_code)))
      true
    else
      false
    end
  end

  def find_rc_transfers(params)
    rc_transfers = RcTransfer.order("id desc")
    rc_transfers = rc_transfers.where.not("status_code IN ('BALINQ FAILED','SKIP CREDIT:NO BALANCE')") if !(params[:remove_default].present? && params[:remove_default] == 'Y')
    rc_transfers = rc_transfers.where("rc_transfer_code IN (?)", params[:rc_transfer_code].split(",").collect(&:strip)) if params[:rc_transfer_code].present?
    rc_transfers = rc_transfers.where("bene_account_no IN (?)", params[:bene_account_no].split(",").collect(&:strip)) if params[:bene_account_no].present?
    rc_transfers = rc_transfers.where("debit_account_no IN (?)", params[:debit_account_no].split(",").collect(&:strip)) if params[:debit_account_no].present?
    rc_transfers = rc_transfers.where("transfer_rep_ref IN (?)", params[:transfer_rep_ref].split(",").collect(&:strip)) if params[:transfer_rep_ref].present?
    rc_transfers = rc_transfers.where("transfer_amount>=? and transfer_amount<=?",params[:from_transfer_amount].to_f,params[:to_transfer_amount].to_f) if params[:from_transfer_amount].present? and params[:to_transfer_amount].present?
    rc_transfers = rc_transfers.where("status_code = ?", params[:status_code]) if params[:status_code].present?
    rc_transfers = rc_transfers.where("notify_status = ?", params[:notify_status]) if params[:notify_status].present?
    rc_transfers = rc_transfers.where("mobile_no IN (?)",params[:mobile_no].split(",").collect(&:strip)) if params[:mobile_no].present?
    rc_transfers = rc_transfers.where("pending_approval = ?", params[:pending_approval]) if params[:pending_approval].present?
    rc_transfers
  end

end
