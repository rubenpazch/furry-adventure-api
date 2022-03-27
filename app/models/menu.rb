class Menu < ApplicationRecord
  has_many :sub_menus, class_name: 'SubMenu', foreign_key: 'menus_id'
  belongs_to :account, class_name: "Account"
end
