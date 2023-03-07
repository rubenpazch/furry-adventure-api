class ProductSerializer
  include JSONAPI::Serializer
  set_type :product
  attributes :id, :name, :slug, :price, :quantity, :sale_price, :image, :sku, :product_images, :category, :description
  belongs_to :category, class_name: 'Products::Category', foreign_key: 'product_category_id'
  has_many :product_images, class_name: 'Products::Image', foreign_key: 'product_id'
end
