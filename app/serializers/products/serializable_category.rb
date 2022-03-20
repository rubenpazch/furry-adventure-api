class Products::SerializableCategory < JSONAPI::Serializable::Resource
  type 'product_categories'
  attributes :id, :title, :description, :slug, :product_count, :icon
  has_one :product_category_images, class_name: "Products::Categories::Image", foreign_key: 'product_categories_id'
end
