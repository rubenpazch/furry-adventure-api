class DropOrganization < ActiveRecord::Migration[6.1]
  def change
    drop_table :organizations
  end
end
