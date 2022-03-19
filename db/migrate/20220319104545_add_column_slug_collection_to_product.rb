class AddColumnSlugCollectionToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :slug_collection, :string
  end
end
