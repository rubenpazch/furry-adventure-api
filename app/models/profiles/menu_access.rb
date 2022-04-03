module Profiles
  class MenuAccess < ApplicationRecord
    self.table_name = "menu_accesses"
    belongs_to :menu, class_name: "Profiles::Menu", foreign_key: "menus_id"
    belongs_to :profile, class_name: "Profile", foreign_key: "profile_id"
  end
end
