class UploadedFile < ApplicationRecord 
  mount_uploader :file_name, CsvUploader
  before_validation :validate_file_name_is_unique, :on => :create


  private

  def validate_file_name_is_unique
    if UploadedFile.where(:file_name => file_name.file.original_filename).count > 0
      errors.add(:file_name, {code: 400, message: "'#{file_name.file.original_filename}' already exists"})
    end
  end
end