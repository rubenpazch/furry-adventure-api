# frozen_string_literal: true

class CreateModules < ActiveRecord::Migration[6.1]
  def change
    create_table :modules do |t|
      t.string :name
      t.string :description
      t.boolean :view
      t.boolean :create
      t.boolean :edit
      t.boolean :delete

      t.timestamps
    end
  end
end
