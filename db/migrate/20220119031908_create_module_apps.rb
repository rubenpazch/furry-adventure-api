# frozen_string_literal: true

class CreateModuleApps < ActiveRecord::Migration[6.1]
  def change
    create_table :module_apps do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
