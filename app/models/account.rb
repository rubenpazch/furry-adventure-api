class Account < ApplicationRecord
  belongs_to :organizations, class_name: "Organization"
  has_many :products
  #has_many :menus, class_name: "Menu"
  has_many :roles, class_name: "Role", foreign_key: "account_id"
  has_many :people, class_name: "Person", foreign_key: "account_id"
end
