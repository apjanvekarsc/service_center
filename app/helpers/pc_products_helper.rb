module PcProductsHelper
  def find_pc_products(params)
    pc_products = (params[:approval_status].present? and params[:approval_status] == 'U') ? PcProducts.unscope : PcProduct
    pc_products = pc_products.where("code=?",params[:code].downcase) if params[:code].present?
    pc_products = pc_products.where("program_code=?",params[:program_code].downcase) if params[:program_code].present?
    pc_products
  end
end
