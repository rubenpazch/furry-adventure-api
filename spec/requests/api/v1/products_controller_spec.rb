require "rails_helper"

RSpec.describe "Api::V1::Products", type: :request do
  context "GET /index" do
    let(:valid_organization) { create :organization }
    let(:valid_account) { build :account }
    let(:valid_category) { create :products_category }
    let(:valid_product) { build :product }
    let(:valid_product_two) { build :product }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!
      valid_product.account_id = valid_account.id
      valid_product.product_category_id = valid_category.id
      valid_product.save!

      valid_product_two.account_id = valid_account.id
      valid_product_two.product_category_id = valid_category.id
      valid_product_two.save!
    end

    it "should show a product" do
      headers = { "ACCEPT" => "application/json" }
      get "/api/v1/products/#{valid_product_two.id}", headers: headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to equal(valid_product_two.id)
    end

    it "should return a list of products" do
      headers = { "ACCEPT" => "application/json" }
      get "/api/v1/products", headers: headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.length.to_i).to equal(2)
    end
  end
end
