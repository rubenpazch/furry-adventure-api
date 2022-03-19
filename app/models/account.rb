class Account < ApplicationRecord
  belongs_to :organizations
  has_many :products
end
