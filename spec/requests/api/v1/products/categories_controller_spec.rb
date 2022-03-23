require "rails_helper"

RSpec.describe "Api::V1::Products::Categories", type: :request do
  context "GET /index" do
    let(:valid_category) { build(:products_category) }
    let(:valid_category_image) { build(:product_category_images) }
    let(:valid_category_two) { build(:products_category) }
    let(:valid_category_image_two) { build(:product_category_images) }

    before(:each) do
      valid_category.save!
      valid_category_image.product_categories_id = valid_category.id
      valid_category_image.save!
      valid_category_two.save!
      valid_category_image_two.product_categories_id = valid_category_two.id
      valid_category_image_two.save!
    end

    it "should return a list of categories" do
      headers = { "ACCEPT" => "application/json" }
      get "/api/v1/products/categories", headers: headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to be_equal(2)
    end
  end
end
