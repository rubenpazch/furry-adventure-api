module Products 
  class Category < ActiveRecord::Base 
    self.table_name = "product_categories"
    has_one :product_category_images, class_name: "Products::Categories::Image", foreign_key: 'product_categories_id'
    validate :slug_equal_to_title_with_dashes

    def slug_equal_to_title_with_dashes
      if title.downcase.split(' ').join('-') != slug 
        errors.add(:slug_compared_with_title, "Need to be equal with dashes")
      end
    end
  end
end