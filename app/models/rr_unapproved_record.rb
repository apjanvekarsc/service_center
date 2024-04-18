class RrUnapprovedRecord < ActiveRecord::Base
  belongs_to :rr_approvable, :polymorphic => true#,:unscoped => true
  RR_TABLES = ['IncomingFile']
end