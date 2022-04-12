class Product < ApplicationRecord
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :slug, presence: true
  validates :title, presence: true
  belongs_to :account
  belongs_to :category, class_name: "Products::Category", foreign_key: 'product_category_id'
  has_many :product_images, class_name: "Products::Image", foreign_key: 'product_id'

end
