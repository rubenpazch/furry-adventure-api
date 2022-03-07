require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:all) do 
    @product_valid = create(:product)
    @product_invalid = create(:product)

  end

  it "has valid attributes" do
    expect(@product_valid).to be_valid
  end

  it "has invalid attribute for price in product" do
    @product_invalid.price = 'test'
    expect(@product_invalid).to be_invalid
    @product_invalid.price = -1
    expect(@product_invalid).to be_invalid
  end 
end
