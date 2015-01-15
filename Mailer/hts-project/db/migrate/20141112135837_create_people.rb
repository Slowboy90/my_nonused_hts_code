class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :salutation
      t.string :first_name
      t.string :initials
      t.string :last_name
      t.integer :graduation_year
      t.string :major
      t.string :street
      t.string :number
      t.string :zipcode
      t.string :city
      t.string :email
      t.integer :user_id
      t.string :unique_code

      t.timestamps
    end
  end
end
