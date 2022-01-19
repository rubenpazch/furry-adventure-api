class DeleteUserFromRole < ActiveRecord::Migration[6.1]
  def change
    remove_column :roles, :user_id
  end
end
