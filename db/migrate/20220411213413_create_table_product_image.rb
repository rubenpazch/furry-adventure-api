# frozen_string_literal: true

class CreateTableProductImage < ActiveRecord::Migration[7.0]
  def change
    create_table :product_images do |t|
      t.string :thumbnail
      t.string :original
      t.belongs_to :product, foreign_key: true
      t.timestamps
    end
  end
end
