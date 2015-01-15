class Photo < ActiveRecord::Base
	belongs_to :photoalbum
	mount_uploader :file_name, EventPhotosUploader
end
