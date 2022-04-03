class CreateAccessPrivileges < ActiveRecord::Migration[6.1]
  def change
    create_table :access_privileges do |t|
      t.references :profile, index: true, foreign_key: true
      t.references :privilege, index: true, foreign_key: true
      t.timestamps
    end
  end
end
