module AttachmentsHelper
  
  def normal_attachment(attachment)
    url = attachment.file.path
    send_file(url,:disposition => "attachment", :url_based_filename => false)
  end
  
end