class Products::ProductCategorySerializer
  include JSONAPI::Serializer
  set_type :products_category
  attributes :id, :title, :description, :slug, :product_count, :icon, :product_category_images
  has_one :product_category_images, class_name: "Products::Categories::Image", foreign_key: 'product_categories_id'
end
