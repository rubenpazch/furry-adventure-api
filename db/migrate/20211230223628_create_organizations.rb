# frozen_string_literal: true

class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :description
      t.string :organization_id
      t.string :legal_name
      t.string :address
      t.integer :country_code
      t.integer :city_code
      t.integer :province
      t.integer :district

      t.timestamps
    end
  end
end
