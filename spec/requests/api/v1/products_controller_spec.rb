require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  context "GET /index" do
    let(:valid_product)  { build :product }
    let(:valid_category)  { create :category }

    it "should return a list of products" do 
      valid_product.product_category_id = valid_category.id
      valid_product.save!
      headers = { "ACCEPT" => "application/json" }
      get "/api/v1/products"
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.length.to_i).to equal(1)
    end
  end
end
