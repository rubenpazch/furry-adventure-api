class CreateProfilesMenuAccesses < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles_menu_accesses do |t|

      t.timestamps
    end
  end
end
