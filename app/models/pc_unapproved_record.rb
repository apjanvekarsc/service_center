class PcUnapprovedRecord < ApplicationRecord
  belongs_to :pc_approvable, :polymorphic => true#,:unscoped => true
  PC_TABLES = ['PcApp','PcFeeRule', 'PcProgram', 'PcProduct', 'IncomingFile']
end
