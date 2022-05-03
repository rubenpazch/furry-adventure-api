class Person < ApplicationRecord
  has_many :optometric_histories, class_name: "OptometricHistory", foreign_key: "people_id"
  belongs_to :account, class_name: "Account", foreign_key: "account_id"
  validates :account, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :cell_phone, presence: :true
end
