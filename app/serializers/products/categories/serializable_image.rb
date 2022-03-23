class Products::Categories::SerializableImage < JSONAPI::Serializable::Resource
  type 'product_category_images'
  attributes :thumbnail, :original, :product_categories_id
  belongs_to :product_categories, class_name: "Products::Category", foreign_key: 'product_categories_id'
end
