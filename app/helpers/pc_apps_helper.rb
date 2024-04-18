module PcAppsHelper
  def find_pc_apps(params)
    pc_apps = (params[:approval_status].present? and params[:approval_status] == 'U') ? PcApp.unscope : PcApp
    pc_apps = pc_apps.where("program_code=?",params[:program_code].downcase) if params[:program_code].present?
    pc_apps = pc_apps.where("app_id=?",params[:app_id]) if params[:app_id].present?
    pc_apps
  end
end
