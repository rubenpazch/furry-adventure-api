class Role < ApplicationRecord
  belongs_to :account
  belongs_to :profile, class_name: "Profile", foreign_key: "profile_id"
end
