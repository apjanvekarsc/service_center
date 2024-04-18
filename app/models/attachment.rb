class Attachment < ApplicationRecord
  # attr_accessible :file, :note, :user_id
  belongs_to :attachable, :polymorphic => true
  belongs_to :user
  before_create :set_name
  validate :validate_file_name
  ATTACHMENT_LIMIT = 2.megabytes.to_i
  validate :file_size, :on => [:create]
  BlackList = %w(exe vbs rb sh jar html msi bat com bin vb)
  #mount_uploader :file, WhitelistedIdentityUploader

  def file_size
    unless file.file.nil?
      if file.file.size.to_f/(1000*1000) > ATTACHMENT_LIMIT.to_f/(1000*1000)
        limit = ATTACHMENT_LIMIT/(1000*1000).to_i
        errors.add(file.filename, "cannot be greater than #{limit} MB")
      end
    end
  end

  def validate_file_name
    if file.filename.present?
      file.filename.split(".").each do |ext|
        errors.add(:base, "Invalid file extension") and return false if BlackList.include?(ext)
      end
    end
  end

  def set_name
    if note.blank?
      self.note = file.filename
    end
  end
end