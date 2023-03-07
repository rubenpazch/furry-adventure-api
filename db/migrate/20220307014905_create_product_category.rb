# frozen_string_literal: true

class CreateProductCategory < ActiveRecord::Migration[7.0]
  def change
    create_table :product_categories do |t|
      t.string :title
      t.string :description
      t.string :slug
      t.integer :product_count
      t.string :icon

      t.timestamps
    end
  end
end
