class ProcessedImage < ActiveRecord::Base
  belongs_to :person
  mount_uploader :file_name, GreenScreenImageUploader
  validates_presence_of :file_name, :message => 'File was not uploaded'
end
