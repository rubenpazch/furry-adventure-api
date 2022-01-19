class AddColumnToRole < ActiveRecord::Migration[6.1]
  def change
    add_column :roles, :is_root, :boolean
    add_column :roles, :parent_id, :integer
  end
end
