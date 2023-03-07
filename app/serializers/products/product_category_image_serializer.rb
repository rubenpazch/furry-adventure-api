# frozen_string_literal: true

module Products
  class ProductCategoryImageSerializer
    include JSONAPI::Serializer
    set_type :product_category_images
    attributes :thumbnail, :original, :product_categories_id
    belongs_to :product_categories, class_name: 'Products::Category', foreign_key: 'product_categories_id'
  end
end
