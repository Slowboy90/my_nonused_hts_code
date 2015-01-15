class News < ActiveRecord::Base
	mount_uploader :image, NewsUploader
end
