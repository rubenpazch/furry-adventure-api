class SubMenu < ApplicationRecord
  belongs_to :menu, class_name: 'Menu', foreign_key: 'menus_id'
end
