# encoding: utf-8

class GreenScreenImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
   include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    filename = model.send(:"#{mounted_as}_identifier")
    "uploads/processed/#{filename[0..15]}/#{filename[15..30]}"
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
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

   process :convert => 'png' # Convert to PNG so transparency works
   process :removescreen # Remove the green screen from the image

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end
  private
  def removescreen
    manipulate! do |source|
      original = source
      background = MiniMagick::Image::open(current_path) # Create alternate copy of the image for editing purposes
      background.clone.fx('p{0,0}') # Set all pixels to the pixel found @ px 0,0

      diffmap = original.composite(background, "png") do |c| # Compare the image to the background color
        c.compose 'Difference' # Set composite type to Difference mapping
        c.alpha 'Off' # make sure that transparent pixels are gone
      end
      diffmap = diffmap.modulate '100,0'        # Remove colors
      diffmap.format 'png'                      # Set to PNG because renders sometimes revert to JPEG
      diffmap = diffmap.combine_options do |c|
        c.fuzz '12%'                           # Set allowance for different green color
        c.draw 'matte 1,1 replace'          # Replace all pixels the same color as the pixel at 1,1
        c.fill 'transparent'                  # Use transparent as the fill color
        c.alpha 'Set'                         # Enable the alpha channel
      end
      diffmap = diffmap.combine_options do|c|
        c.channel('matte') # select the opacity channel
        c.separate # And get it on it's own
      end
      diffmap = diffmap.alpha('Off').format('png')
      result = source.composite(diffmap, "png") do |update| # Lay difference map over the original image
        update.compose 'CopyOpacity'      # Set compose type to opacity masking
      end
      result # Submit resulted image to CarrierWave for saving
    end
  end
   def sha1_for(file)
     Digest::SHA1.hexdigest file.read
   end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
