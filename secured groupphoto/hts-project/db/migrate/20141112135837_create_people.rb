class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.integer :graduation_year
      t.string :major
      t.string :address
      t.string :postcode
      t.string :city
      t.string :email
      t.integer :user_id

      t.timestamps
    end
  end
end
