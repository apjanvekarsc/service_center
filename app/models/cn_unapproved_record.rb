class CnUnapprovedRecord < ApplicationRecord
  belongs_to :cn_approvable, :polymorphic => true#,:unscoped => true
  CN_TABLES = ['IncomingFile']
end