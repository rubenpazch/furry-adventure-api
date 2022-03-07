class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price
      t.boolean :published
      t.string :description
      t.string :slug
      t.decimal :sale_price

      t.timestamps
    end
  end
end
