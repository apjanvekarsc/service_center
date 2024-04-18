class EmailAlert
  TEMPLATE_FOLDER = Rails.root.join('vendor','email_templates','verify_email_content')

  def self.send_email(inward_remittance,to_email_ids)
    email_template = read_template
    email_to(email_template, inward_remittance, to_email_ids) if email_template.present?
  end

  def self.read_template
    File.open(TEMPLATE_FOLDER, "r:UTF-8") {|io| io.read} rescue nil
  end

  def self.email_to(email_template, inward_remittance, to_email_ids)
    content = Florrick.convert(email_template, :inward_remittance => inward_remittance)
    subject = "Your request for whitelisting is verified"
    recipient = to_email_ids
    Delayed::Job.enqueue EmailAlertJob.new(content, subject, recipient), queue: :emails
  end
end