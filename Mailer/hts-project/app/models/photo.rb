# Class for uploading event photos
class Photo < ActiveRecord::Base
  belongs_to :photoalbum
  mount_uploader :file_name, EventPhotosUploader
  validates_presence_of :file_name, message: 'Er is geen foto geselecteerd!'
end
