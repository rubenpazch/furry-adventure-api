class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.belongs_to :profile
      t.belongs_to :user
      t.timestamps
    end
  end
end
