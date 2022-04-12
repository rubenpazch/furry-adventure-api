class AddColumnsToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :name, :string
    add_column :products, :quantity, :integer
    add_column :products, :sku, :string
    add_column :products, :image, :string
  end
end
