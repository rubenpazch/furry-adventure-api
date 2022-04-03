module Profiles
  class AccessPrivilege < ApplicationRecord
    self.table_name = "access_privileges"
    belongs_to :profile, class_name: "Profile", foreign_key: "profile_id"
    belongs_to :privilege, class_name: "Profiles::Privilege", foreign_key: "privilege_id"
    validates :profile_id, presence: true
    validates :privilege_id, presence: true
  end
end
