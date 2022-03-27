class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus do |t|
      t.string :title
      t.string :link_to
      t.boolean :hasSubMenu
      t.boolean :isRoot
      t.timestamps
    end
  end
end
