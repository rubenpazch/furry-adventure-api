module Products
  class Image < ApplicationRecord
    self.table_name = 'product_images'
    belongs_to :product, class_name: 'Product', foreign_key: 'product_id'
  end
end
