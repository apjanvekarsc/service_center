module PcProgramsHelper
  def find_pc_programs(params)   
    pc_programs = (params[:approval_status].present? and params[:approval_status] == 'U') ? PcPrograms.unscope : PcProgram   
    pc_programs = pc_programs.where("code=?",params[:code].downcase) if params[:code].present?    
    pc_programs   
  end
end
