class AddReferenceToRole < ActiveRecord::Migration[7.0]
  def change
    add_reference :roles, :account, null: false, foreign_key: true
  end
end
