class Account < ApplicationRecord
  belongs_to :organizations, class_name: "Organization"
  has_many :products
end
