class Account < ApplicationRecord
  belongs_to :organizations, class_name: "Organization"
  has_many :products
  has_many :menus, class_name: "Menu"
  has_many :roles, class_name: "Profiles::Role", foreign_key: "account_id"
end
