# frozen_string_literal: true

module Profiles
  class SubMenuSerializer
    include JSONAPI::Serializer
    attributes :title, :link_to, :hasSubMenu, :menus_id
    belongs_to :menu, class_name: 'Profiles::Menu', foreign_key: 'menus_id'
  end
end
