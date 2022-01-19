class DropTableProfilePrivilege < ActiveRecord::Migration[6.1]
  def change
    drop_table :profile_privileges
  end
end
