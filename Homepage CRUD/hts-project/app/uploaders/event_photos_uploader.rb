# encoding: utf-8

class EventPhotosUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  version :web do
    process :resize_to_fit => [800, 800]
  end

  version :thumb do
    process :resize_to_fill => [250,250]
  end
  process :convert => 'png'


  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

  def store_dir
    filename = model.send(:"#{mounted_as}_identifier")
    "uploads/event/#{filename[0..15]}/#{filename[15..30]}"
  end

  def filename
    if original_filename
      existing = model.send(:"#{mounted_as}_identifier")
# reuse the existing file name from the model if present.
# otherwise, generate a new one (and cache it in an instance variable)
      @generated_filename ||= if existing.present?
                                existing
                              else
                                "#{sha1_for file}-#{SecureRandom.hex(4)}.png"
                              end
    end
  end


  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Filename is being hashed my the SHA1 protocol, the extension is not being hashed but added on the end.

  def sha1_for file
    Digest::SHA1.hexdigest file.read
  end

end
