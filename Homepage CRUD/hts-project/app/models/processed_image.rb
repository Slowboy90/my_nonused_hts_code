# Green screen image processing model
class ProcessedImage < ActiveRecord::Base
  belongs_to :person
  mount_uploader :file_name, GreenScreenImageUploader
  store_in_background :file_name

  def file_name_changed?
    true
  end
end
