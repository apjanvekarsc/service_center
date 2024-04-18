class PendingInwardRemittance < ActiveRecord::Base

  validates_presence_of :inward_remittance_id, :broker_uuid

end
