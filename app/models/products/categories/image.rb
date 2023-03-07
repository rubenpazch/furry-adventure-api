module Products
  module Categories
    class Image < ActiveRecord::Base
      self.table_name = 'product_category_images'
      belongs_to :product_categories, class_name: 'Products::Category', foreign_key: 'product_categories_id'
    end
  end
end
