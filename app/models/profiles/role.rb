module Profiles
  class Role < ApplicationRecord
    self.table_name = "roles"
    belongs_to :account
    belongs_to :profile, class_name: "Profile", foreign_key: "profile_id"
  end
end
