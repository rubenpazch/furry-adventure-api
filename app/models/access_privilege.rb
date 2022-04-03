class AccessPrivilege < ApplicationRecord
  belongs_to :profile
  belongs_to :privilege
  validates :profile_id, presence: true
  validates :privilege_id, presence: true
end
