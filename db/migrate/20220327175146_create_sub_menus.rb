# frozen_string_literal: true

class CreateSubMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :sub_menus do |t|
      t.string :title
      t.string :link_to
      t.boolean :hasSubMenu
      t.references :menus, index: true, foreign_key: true
      t.timestamps
    end
  end
end
