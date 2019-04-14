class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :address_line_1
      t.string :address_line_2 
      t.string :street_code
      t.integer :parent_id

      t.timestamps
    end
  end
end