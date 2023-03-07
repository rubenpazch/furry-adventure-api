module Profiles
  class Menu < ApplicationRecord
    self.table_name = 'menus'
    has_many :sub_menus, class_name: 'Profiles::SubMenu', foreign_key: 'menus_id'
    belongs_to :account, class_name: 'Account'
    has_many :menu_accesses, class_name: 'Profiles::MenuAccess', foreign_key: 'menus_id'
  end
end
