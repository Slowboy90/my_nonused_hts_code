class CreateGroupphotos < ActiveRecord::Migration
  def change
    create_table :groupphotos do |t|
      t.string :file_name
      t.integer :person_id

      t.timestamps
    end
  end
end
