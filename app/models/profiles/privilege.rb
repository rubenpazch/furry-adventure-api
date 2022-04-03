module Profiles
  class Privilege < ApplicationRecord
    self.table_name = "privileges"
    has_many :access_privileges, class_name: "Profiles::AccessPrivilege", foreign_key: "privilege_id"
    has_many :profiles, through: :access_privileges, class_name: "Profiles::AccessPrivilege"
  end
end
