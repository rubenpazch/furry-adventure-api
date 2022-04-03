class Profile < ApplicationRecord
  has_many :access_privileges, class_name: "AccessPrivilege", foreign_key: "profile_id"
  has_many :roles, class_name: "Role", foreign_key: "profile_id"
  has_many :privileges, through: :access_privileges
end
