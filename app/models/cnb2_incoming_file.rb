class Cnb2IncomingFile < ActiveRecord::Base  
  has_one :incoming_file, :foreign_key => "file_name", :primary_key => "file_name"
end
