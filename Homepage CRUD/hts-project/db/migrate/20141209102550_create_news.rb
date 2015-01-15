class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.text :content
      t.string :image
      t.boolean :before

      t.timestamps
    end
  end
end
