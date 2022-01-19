class DropModuleTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :modules
  end
end
