require "rails_helper"

RSpec.describe "Api::V1::Products::Categories", type: :request do
  context "GET /index" do
    let(:valid_category) { build(:products_category) }
    let(:valid_category_image) { build(:product_category_images) }

    before(:each) do
      valid_category.save!
      valid_category_image.product_categories_id = valid_category.id
      valid_category_image.save!
    end

    it "should return a list of categories" do
      headers = { "ACCEPT" => "application/json" }
      get "/api/v1/products/categories", headers: headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["data"].length).to be_equal(1)
    end
  end
end
