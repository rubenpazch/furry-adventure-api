class Privilege < ApplicationRecord
  has_many :access_privileges, class_name: "AccessPrivilege", foreign_key: "privilege_id"
  has_many :profiles, through: :access_privileges
end
