# frozen_string_literal: true

class DeleteColumnsFromModule < ActiveRecord::Migration[6.1]
  def change
    remove_column :modules, :view
    remove_column :modules, :edit
    remove_column :modules, :create
    remove_column :modules, :delete
  end
end
