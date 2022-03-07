module Products 
  class Category < ActiveRecord::Base 
    self.table_name = "product_categories"
  end
end