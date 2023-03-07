class Profiles::SubMenuSerializer
  include JSONAPI::Serializer
  attributes :title, :link_to, :hasSubMenu, :menus_id
  belongs_to :menu, class_name: 'Profiles::Menu', foreign_key: 'menus_id'
end
