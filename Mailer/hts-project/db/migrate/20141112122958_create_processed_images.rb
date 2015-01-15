class CreateProcessedImages < ActiveRecord::Migration
  def change
    create_table :processed_images do |t|
      t.string :file_name
      t.integer :person_id

      t.timestamps
    end
  end
end
