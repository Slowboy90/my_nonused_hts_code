class AddFileNameProcessingToProcessedImage < ActiveRecord::Migration
  def change
    add_column :processed_images, :file_name_processing, :boolean, null: false, default: false
    add_column :processed_images, :file_name_tmp, :string
  end
end
