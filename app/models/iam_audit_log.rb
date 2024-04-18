class IamAuditLog < ActiveRecord::Base
  belongs_to :iam_organisation, foreign_key: 'org_uuid' , :primary_key => 'org_uuid', :class_name => 'IamOrganisation'
end