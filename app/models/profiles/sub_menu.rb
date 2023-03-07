module Profiles
  class SubMenu < ApplicationRecord
    self.table_name = 'sub_menus'
    belongs_to :menu, class_name: 'Profiles::Menu', foreign_key: 'menus_id'
  end
end
