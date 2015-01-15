class RemoveFeaturedFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :featured, :boolean
  end
end
