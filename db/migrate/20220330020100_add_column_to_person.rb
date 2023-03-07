# frozen_string_literal: true

class AddColumnToPerson < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :age, :integer
    add_column :people, :ocupation, :string
  end
end
