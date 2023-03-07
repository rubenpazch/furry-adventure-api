require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  context 'GET /index' do
    let(:valid_organization) { create :organization }
    let(:valid_account) { build :account }
    let(:valid_category) { build :products_category }
    let(:valid_product) { build :product }
    let(:valid_product_two) { build :product }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!

      valid_category.account_id = valid_account.id
      valid_category.save!

      valid_product.account_id = valid_account.id
      valid_product.product_category_id = valid_category.id
      valid_product.save!

      valid_product_two.account_id = valid_account.id
      valid_product_two.product_category_id = valid_category.id
      valid_product_two.save!
    end

    it 'should show a product' do
      headers = { 'ACCEPT' => 'application/json' }
      get "/api/v1/products/#{valid_product_two.id}", headers: headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to equal(valid_product_two.id)
    end

    it 'should return a list of products' do
      headers = { 'ACCEPT' => 'application/json' }
      get '/api/v1/products', headers: headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.length.to_i).to equal(2)
    end
  end

  context 'POST /create' do
    let(:profile_owner) { create(:profile) }
    let(:role_owner) { build(:role) }
    let(:valid_organization) { create :organization }
    let(:valid_account) { build :account }
    let(:valid_category) { build :products_category }
    let(:valid_product) { build :product }
    let(:valid_product_two) { build :product }
    let(:valid_user) { build :user }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!

      role_owner.account_id = valid_account.id
      role_owner.profile_id = profile_owner.id
      role_owner.save!

      valid_category.account_id = valid_account.id
      valid_category.save!

      valid_product_two.account_id = valid_account.id
      valid_product_two.product_category_id = valid_category.id
      valid_product_two.save!
      valid_user.account_id = valid_account.id
      valid_user.role_id = role_owner.id
      valid_user.save!
    end

    it 'should create a product' do
      headers = { 'ACCEPT' => 'application/json',
                  'Authorization' => JsonWebToken.encode(user_id: valid_user.id) }
      post '/api/v1/products', params: {
        product: {
          title: valid_product.title,
          price: valid_product.price,
          published: valid_product.published,
          description: valid_product.description,
          slug: valid_product.slug,
          sale_price: valid_product.sale_price,
          product_category_id: valid_category.id,
          account_id: valid_account.id,
          slug_collection: valid_category.slug
        }
      }, headers: headers, as: :json
      expect(response).to have_http_status(:created)
    end

    it 'should forbid create product' do
      headers = { 'ACCEPT' => 'application/json' }
      post '/api/v1/products', params: {
        product: {
          title: valid_product.title,
          price: valid_product.price,
          published: valid_product.published,
          description: valid_product.description,
          slug: valid_product.slug,
          sale_price: valid_product.sale_price,
          product_category_id: valid_category.id,
          account_id: valid_account.id,
          slug_collection: valid_category.slug
        }
      }, headers: headers, as: :json
      expect(response).to have_http_status(:forbidden)
    end
  end

  context 'PATCH /update' do
    let(:profile_owner) { create(:profile) }
    let(:role_owner) { build(:role) }
    let(:valid_organization) { create :organization }
    let(:valid_account) { build :account }
    let(:valid_category) { build :products_category }
    let(:valid_product) { build :product }
    let(:valid_product_two) { build :product }
    let(:valid_user) { build :user }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!

      role_owner.account_id = valid_account.id
      role_owner.profile_id = profile_owner.id
      role_owner.save!

      valid_category.account_id = valid_account.id
      valid_category.save!

      valid_product_two.account_id = valid_account.id
      valid_product_two.product_category_id = valid_category.id
      valid_product_two.save!
      valid_user.account_id = valid_account.id
      valid_user.role_id = role_owner.id
      valid_user.save!
    end

    it 'should update a product' do
      headers = { 'ACCEPT' => 'application/json',
                  'Authorization' => JsonWebToken.encode(user_id: valid_user.id) }
      patch "/api/v1/products/#{valid_product_two.id}", params: {
        product: {
          title: 'aleatory string'
        }
      }, headers: headers, as: :json
      expect(response).to have_http_status(:success)
    end
  end
end
