class IamAuditRulesController < ApplicationController
  #authorize_resource
  before_action :authenticate_user!
  before_action :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  
  def edit
    @iam_audit_rule = IamAuditRule.find_by_id(params[:id])
  end
  
  def update
    @iam_audit_rule = IamAuditRule.find_by_id(params[:id])
    @iam_audit_rule.attributes = params[:iam_audit_rule]
    if !@iam_audit_rule.valid?
      render "edit"
    else
      @iam_audit_rule.updated_by = current_user.id
      @iam_audit_rule.save
      flash[:alert] = 'Rule successfuly modified'
      redirect_to @iam_audit_rule
    end
    rescue ActiveRecord::StaleObjectError
      @iam_audit_rule.reload
      flash[:alert] = 'Someone edited the rule the same time you did. Please re-apply your changes to the rule.'
      render "edit"
  end 

  def show
    @iam_audit_rule = IamAuditRule.find_by_id(params[:id])
  end
  
  def audit_logs
    @record = IamAuditRule.unscoped.find(params[:id]) rescue nil
    @audit = @record.audits[params[:version_id].to_i] rescue nil
  end

  def error_msg
    flash[:alert] = "Rule is not yet configured"
    redirect_to :root
  end

  private

  def iam_audit_rule_params
    params.require(:iam_audit_rule).permit(:iam_organisation_id, :log_bad_org_uuid, :interval_in_mins, :lock_version, :enabled_at)
  end
end
