class Product < ApplicationRecord
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :slug, presence: true
  validates :title, presence: true
end
