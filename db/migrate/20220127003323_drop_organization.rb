# frozen_string_literal: true

class DropOrganization < ActiveRecord::Migration[6.1]
  def change
    drop_table :organizations
  end
end
