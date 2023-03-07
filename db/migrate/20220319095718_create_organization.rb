# frozen_string_literal: true

class CreateOrganization < ActiveRecord::Migration[7.0]
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
