module PcApproval  
  extend ActiveSupport::Concern
  included do
    has_one :pc_unapproved_record, :as => :pc_approvable

    after_create :on_create_create_pc_unapproved_record
    after_destroy :on_destory_remove_pc_unapproved_records
    after_update :on_update_remove_pc_unapproved_records
  end

  def on_create_create_pc_unapproved_record
    if approval_status == 'U'
      PcUnapprovedRecord.create!(:pc_approvable => self)
    end
  end

  def on_destory_remove_pc_unapproved_records
    if approval_status == 'U'
      pc_unapproved_record.delete
    end
  end
  
  def on_update_remove_pc_unapproved_records
    if approval_status == 'A' and approval_status_was == 'U'
      pc_unapproved_record.delete
    end
  end 
  
end