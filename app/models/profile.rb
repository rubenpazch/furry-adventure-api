# frozen_string_literal: true

class Profile < ApplicationRecord
  has_many :access_privileges, class_name: 'Profiles::AccessPrivilege', foreign_key: 'profile_id'
  has_many :roles, class_name: 'Role', foreign_key: 'profile_id'
  has_many :privileges, through: :access_privileges, class_name: 'Profiles::AccessPrivilege'
  has_many :menu_accesses, class_name: 'Profiles::MenuAccess', foreign_key: 'profile_id'
  has_many :menus, through: :menu_accesses, class_name: 'Profiles::Menu', foreign_key: 'profile_id'
end
