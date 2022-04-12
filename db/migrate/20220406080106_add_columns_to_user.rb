class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :avatar, :string
    add_column :users, :last_login, :date
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
