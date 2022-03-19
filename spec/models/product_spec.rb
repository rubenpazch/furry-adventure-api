require 'rails_helper'

RSpec.describe Product, type: :model do
  context "has valid product" do 
    let(:valid_product)  { build :product }
    let(:valid_category)  { create :products_category }

    it "with valid attributes" do
      valid_product.product_category_id = valid_category.id
      valid_product.save!
      expect(valid_product).to be_valid
    end
  end

  context "has invalid product" do 
    let(:invalid_product)  { build :product }
    let(:valid_category)  { create :products_category }

    it "with invalid title" do
      invalid_product.product_category_id = valid_category.id
      invalid_product.title = nil
      expect(invalid_product).to be_invalid
    end

    it "with empty title to be invalid" do
      invalid_product.product_category_id = valid_category.id
      invalid_product.title = ''
      expect(invalid_product).to be_invalid
    end

    it "with invalid slug" do
      invalid_product.product_category_id = valid_category.id
      invalid_product.slug = nil
      expect(invalid_product).to be_invalid
    end

    it "with empty slug to be invalid" do
      invalid_product.product_category_id = valid_category.id
      invalid_product.slug = ''
      expect(invalid_product).to be_invalid
    end

    it "with price greater than zero to be valid" do
      invalid_product.product_category_id = valid_category.id
      invalid_product.price = 1
      expect(invalid_product).to be_valid
    end

    it "with price lower than zero to be invalid" do
      invalid_product.product_category_id = valid_category.id
      invalid_product.price = -2
      expect(invalid_product).to be_invalid
    end
  end
end
