require 'rails_helper'

RSpec.describe Product, type: :model do
  context "has valid product" do 
    let(:valid_product)  { build :product }
    let(:valid_category)  { create :category }

    it "with valid attributes" do
      valid_product.product_category_id = valid_category.id
      valid_product.save!
      expect(valid_product).to be_valid
    end

    it "with valid slug" do 
      
    end
  end

  context "has invalid product" do 
    let(:invalid_product)  { build :product }
    let(:invalid_category)  { create :category }

    it "with invalid slug" do 
    end
  end
end
