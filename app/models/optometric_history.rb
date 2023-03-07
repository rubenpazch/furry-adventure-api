class OptometricHistory < ApplicationRecord
  belongs_to :people, class_name: 'Person', foreign_key: 'people_id'
end
