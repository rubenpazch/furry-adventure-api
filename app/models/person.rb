class Person < ApplicationRecord
  #has_one :user, class_name: "user", foreign_key: "user_id"
  has_many :optometric_histories, class_name: "OptometricHistory", foreign_key: "people_id"
end
