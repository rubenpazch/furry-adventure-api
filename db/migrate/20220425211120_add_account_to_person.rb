# frozen_string_literal: true

class AddAccountToPerson < ActiveRecord::Migration[7.0]
  def change
    add_reference :people, :account, index: true, foreign_key: true
  end
end
