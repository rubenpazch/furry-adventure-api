class CreateAccessPrivileges < ActiveRecord::Migration[6.1]
  def change
    create_table :access_privileges do |t|
      t.uuid "profile_id"
      t.integer "privilege_id"
      t.timestamps
    end
  end
end
