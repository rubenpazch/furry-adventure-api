# frozen_string_literal: true

module Products
  class ImageSerializer
    include JSONAPI::Serializer
    set_type :product_images
    attributes :thumbnail, :original
    belongs_to :product, class_name: 'Product', foreign_key: 'product_id'
  end
end
