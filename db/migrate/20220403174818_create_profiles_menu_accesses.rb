# frozen_string_literal: true

class CreateProfilesMenuAccesses < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles_menu_accesses, &:timestamps
  end
end
