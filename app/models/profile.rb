class Profile < ApplicationRecord
  has_and_belongs_to_many :privileges
end
