class IamAuditLogsController < ApplicationController
  #authorize_resource
  before_action :authenticate_user!
  before_action :block_inactive_user!
  respond_to :json
  include ApplicationHelper
  
  
  def index
    if request.get?
      @searcher = IamAuditLogSearcher.new(params.permit(:page))
    else
      @searcher = IamAuditLogSearcher.new(search_params)
    end
    @records = @searcher.paginate
  end
  
  def show
    @iam_audit_log = IamAuditLog.find(params[:id])
  end
  
  private
  
    def search_params
      params.permit(:page, :org_uuid, :cert_dn, :source_ip)
    end
end