module SuApproval  
  extend ActiveSupport::Concern
  included do
    has_one :su_unapproved_record, :as => :su_approvable

    after_create :on_create_create_su_unapproved_record
    after_destroy :on_destory_remove_su_unapproved_records
    after_update :on_update_remove_su_unapproved_records
  end

  def on_create_create_su_unapproved_record
    if approval_status == 'U'
      SuUnapprovedRecord.create!(:su_approvable => self)
    end
  end

  def on_destory_remove_su_unapproved_records
    if approval_status == 'U'
      su_unapproved_record.delete
    end
  end
  
  def on_update_remove_su_unapproved_records
    if approval_status == 'A' and approval_status_was == 'U'
      su_unapproved_record.delete
    end
  end 
  
end