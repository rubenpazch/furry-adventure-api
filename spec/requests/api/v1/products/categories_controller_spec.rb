require 'rails_helper'

RSpec.describe "Api::V1::Products::Categories", type: :request do
  context "GET /index" do
    let(:valid_category)  { create :category }

    it "should return a list of categories" do 
      headers = { "ACCEPT" => "application/json"}
      get "/api/v1/products/categories"
      expect(response).to have_http_status(:ok)
    end
  end
end
