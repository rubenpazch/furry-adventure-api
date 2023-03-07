# frozen_string_literal: true

module Profiles
  class MenuSerializer
    include JSONAPI::Serializer
    attributes :id, :title, :link_to, :hasSubMenu, :isRoot, :account_id, :sub_menus
    has_many :sub_menus, class_name: 'Profiles::SubMenu', foreign_key: 'menus_id'
    # belongs_to :account, class_name: "Account"
    # has_many :menu_accesses, class_name: "Profiles::MenuAccess", foreign_key: "menus_id"
  end
end
