module PcFeeRulesHelper
  def find_pc_fee_rules(params)
    pc_fee_rules = (params[:approval_status].present? and params[:approval_status] == 'U') ? PcFeeRule.unscope : PcFeeRule
    pc_fee_rules = pc_fee_rules.where("product_code=?",params[:product_code].downcase) if params[:product_code].present?
    pc_fee_rules
  end
end
