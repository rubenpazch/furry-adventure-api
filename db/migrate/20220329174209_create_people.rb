class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :doc_id
      t.string :address
      t.string :cell_phone
      t.string :contact_phone
      t.integer :district
      t.integer :province
      t.integer :deparment
      t.integer :country
      t.string :nationality

      t.timestamps
    end
  end
end
