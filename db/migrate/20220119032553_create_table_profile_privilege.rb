class CreateTableProfilePrivilege < ActiveRecord::Migration[6.1]
  def change
    create_table :profile_privileges, id: false do |t|
      t.belongs_to :profiles
      t.belongs_to :privileges
      t.timestamps
    end
  end
end
