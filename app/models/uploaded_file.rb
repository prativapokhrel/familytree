class UploadedFile < ApplicationRecord 
  mount_uploader :file_name, CsvUploader
end