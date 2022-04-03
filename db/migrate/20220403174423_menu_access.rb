class MenuAccess < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_accesses do |t|
      t.references :menus, index: true, foreign_key: true
      t.references :profile, index: true, foreign_key: true
      t.timestamps
    end
  end
end
