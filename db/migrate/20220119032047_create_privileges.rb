class CreatePrivileges < ActiveRecord::Migration[6.1]
  def change
    create_table :privileges do |t|
      t.string :name

      t.timestamps
    end
  end
end
