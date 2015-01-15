class AddUniqueCodeToPerson < ActiveRecord::Migration
  def change
    add_column :people, :unique_code, :string
  end
end
