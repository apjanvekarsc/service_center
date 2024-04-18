module Pc2AppsHelper
  def find_pc2_apps(params)
    pc2_apps = (params[:approval_status].present? and params[:approval_status] == 'U') ? Pc2App.unscope : Pc2App
    pc2_apps = pc2_apps.where("app_id IN (?)",params[:app_id].split(",").collect(&:strip)) if params[:app_id].present?
    pc2_apps
  end
end
