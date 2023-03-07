# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  context 'GET /show' do
    let(:role_owner_adidas) { build(:role) }
    let(:user_adidas) { build(:user) }
    let(:profile_adidas) { create(:profile) }
    let(:organization_adidas) { create(:organization) }
    let(:account_adidas) { build(:account) }

    let(:organization_nike) { create :organization }
    let(:account_nike) { build :account }
    let(:profile_super_admin_nike) { create(:profile) }
    let(:role_super_admin_nike) { build(:role) }
    let(:user_nike) { build(:user) }

    before(:each) do
      account_adidas.organizations_id = organization_adidas.id
      account_adidas.save!

      role_owner_adidas.account_id = account_adidas.id
      role_owner_adidas.profile_id = profile_adidas.id
      role_owner_adidas.save!

      user_adidas.account_id = account_adidas.id
      user_adidas.role_id = role_owner_adidas.id
      user_adidas.save!

      account_nike.organizations_id = organization_nike.id
      account_nike.save!

      role_super_admin_nike.account_id = account_nike.id
      role_super_admin_nike.profile_id = profile_super_admin_nike.id
      role_super_admin_nike.save!

      user_nike.account_id = account_nike.id
      user_nike.role_id = role_super_admin_nike.id
      user_nike.save!
    end

    it 'should show user' do
      headers = { 'ACCEPT' => 'application/json',
                  'Authorization' => JsonWebToken.encode(user_id: user_adidas.id) }
      get "/api/v1/users/#{user_adidas.id}", headers: headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['email']).to eq(user_adidas.email)
    end

    it 'should show forbidden when wrong owner' do
      headers = { 'ACCEPT' => 'application/json',
                  'Authorization' => JsonWebToken.encode(user_id: user_nike.id) }
      get "/api/v1/users/#{user_adidas.id}", headers: headers
      expect(response.status).to eql(403)
    end

    it 'should show forbidden when not token' do
      headers = { 'ACCEPT' => 'application/json' }
      get "/api/v1/users/#{user_adidas.id}", headers: headers
      expect(response.status).to eql(403)
    end

    it 'should show not found when not owner given' do
      headers = { 'ACCEPT' => 'application/json',
                  'Authorization' => JsonWebToken.encode(user_id: nil) }
      get "/api/v1/users/#{user_adidas.id}", headers: headers
      expect(response.status).to eql(404)
    end

    it 'should show not found when not user given' do
      headers = { 'ACCEPT' => 'application/json',
                  'Authorization' => JsonWebToken.encode(user_id: user_nike.id) }
      get '/api/v1/users/999', headers: headers
      expect(response.status).to eql(404)
    end
  end

  context 'POST /created' do
    let(:role_owner_adidas) { build(:role) }
    let(:profile_adidas) { create(:profile) }
    let(:user_adidas) { build(:user) }
    let(:user_adidas_client) { build(:user) }
    let(:organization_adidas) { create(:organization) }
    let(:account_adidas) { build(:account) }
    let(:existing_user_adidas) { build(:user) }

    before(:each) do
      account_adidas.organizations_id = organization_adidas.id
      account_adidas.save!

      role_owner_adidas.account_id = account_adidas.id
      role_owner_adidas.profile_id = profile_adidas.id
      role_owner_adidas.save!

      user_adidas.account_id = account_adidas.id
      user_adidas.role_id = role_owner_adidas.id
      user_adidas.save!
    end

    it 'should create a user' do
      headers = { 'ACCEPT' => 'application/json',
                  'Authorization' => JsonWebToken.encode(user_id: user_adidas.id) }
      post '/api/v1/users', params: {
        user: {
          email: user_adidas_client.email,
          password: user_adidas_client.password_digest,
          first_name: user_adidas_client.first_name,
          last_name: user_adidas_client.last_name,
          account_id: account_adidas.id,
          role_id: role_owner_adidas.id
        }
      }, headers: headers, as: :json
      expect(response).to have_http_status(:created)
    end

    it 'should not create user with taken email' do
      headers = { 'ACCEPT' => 'application/json',
                  'Authorization' => JsonWebToken.encode(user_id: user_adidas.id) }
      post '/api/v1/users', params: {
        user: {
          email: existing_user_adidas.email,
          password: user_adidas.password_digest,
          first_name: user_adidas.first_name,
          last_name: user_adidas.last_name,
          account_id: account_adidas.id
        }
      }, headers: headers, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should not create user account is not given' do
      headers = { 'ACCEPT' => 'application/json',
                  'Authorization' => JsonWebToken.encode(user_id: user_adidas.id) }
      post '/api/v1/users', params: {
        user: {
          email: user_adidas.email,
          password: user_adidas.password_digest,
          first_name: user_adidas.first_name,
          last_name: user_adidas.last_name
        }
      }, headers: headers, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'UPDATE /updated' do
    let(:role_owner_adidas) { build(:role) }
    let(:profile_adidas) { create(:profile) }
    let(:organization_adidas) { create(:organization) }
    let(:account_adidas) { build(:account) }
    let(:existing_user_adidas) { build(:user) }

    before(:each) do
      account_adidas.organizations_id = organization_adidas.id
      account_adidas.save!

      role_owner_adidas.account_id = account_adidas.id
      role_owner_adidas.profile_id = profile_adidas.id
      role_owner_adidas.save!

      existing_user_adidas.account_id = account_adidas.id
      existing_user_adidas.role_id = role_owner_adidas.id
      existing_user_adidas.save!
    end

    it 'should update user with valid token' do
      updated_email = 'testingemail@gmail.com'
      headers = {
        'ACCEPT' => 'application/json',
        'Authorization' => JsonWebToken.encode(user_id: existing_user_adidas.id)
      }
      patch "/api/v1/users/#{existing_user_adidas.id}", params: {
                                                          user: {
                                                            email: updated_email
                                                          }
                                                        },
                                                        headers: headers, as: :json
      expect(response).to have_http_status(:success)
    end

    it 'should forbid update user without token' do
      updated_email = 'testingemail@gmail.com'
      headers = {
        'ACCEPT' => 'application/json'
      }
      patch "/api/v1/users/#{existing_user_adidas.id}", params: {
                                                          user: {
                                                            email: updated_email
                                                          }
                                                        },
                                                        headers: headers, as: :json
      expect(response).to have_http_status(:forbidden)
    end
  end

  context 'DELETE /deleted' do
    let(:role_owner_adidas) { build(:role) }
    let(:profile_adidas) { create(:profile) }
    let(:organization_adidas) { create(:organization) }
    let(:account_adidas) { build(:account) }
    let(:existing_user_adidas) { build(:user) }

    before(:each) do
      account_adidas.organizations_id = organization_adidas.id
      account_adidas.save!

      role_owner_adidas.account_id = account_adidas.id
      role_owner_adidas.profile_id = profile_adidas.id
      role_owner_adidas.save!

      existing_user_adidas.account_id = account_adidas.id
      existing_user_adidas.role_id = role_owner_adidas.id
      existing_user_adidas.save!
    end

    it 'should destroy user with valid token' do
      headers = {
        'ACCEPT' => 'application/json',
        'Authorization' => JsonWebToken.encode(user_id: existing_user_adidas.id)
      }
      delete "/api/v1/users/#{existing_user_adidas.id}", headers: headers, as: :json
      expect(response).to have_http_status(:no_content)
    end

    it 'should destroy user with valid token' do
      headers = {
        'ACCEPT' => 'application/json'
      }
      delete "/api/v1/users/#{existing_user_adidas.id}", headers: headers, as: :json
      expect(response).to have_http_status(:forbidden)
    end
  end

  context 'GET /index' do
    let(:role_owner_adidas) { build(:role) }
    let(:role_sales) { build(:role) }
    let(:user_sales) { build(:user) }
    let(:user_sales1) { build(:user) }
    let(:user_sales2) { build(:user) }
    let(:user_sales3) { build(:user) }
    let(:user_sales4) { build(:user) }
    let(:user_sales5) { build(:user) }
    let(:user_sales6) { build(:user) }

    let(:user_owner) { build(:user) }
    let(:profile_adidas) { create(:profile) }
    let(:profile_sales) { create(:profile) }
    let(:organization_owner) { create(:organization) }
    let(:account_owner) { build(:account) }

    before(:each) do
      account_owner.organizations_id = organization_owner.id
      account_owner.save!

      role_owner_adidas.account_id = account_owner.id
      role_owner_adidas.profile_id = profile_adidas.id
      role_owner_adidas.save!

      role_sales.account_id = account_owner.id
      role_sales.profile_id = profile_sales.id
      role_sales.save!

      user_owner.account_id = account_owner.id
      user_owner.role_id = role_owner_adidas.id
      user_owner.save!

      user_sales.account_id = account_owner.id
      user_sales.role_id = role_sales.id
      user_sales.save!

      user_sales2.account_id = account_owner.id
      user_sales2.role_id = role_sales.id
      user_sales2.save!

      user_sales3.account_id = account_owner.id
      user_sales3.role_id = role_sales.id
      user_sales3.save!

      user_sales4.account_id = account_owner.id
      user_sales4.role_id = role_sales.id
      user_sales4.save!

      user_sales5.account_id = account_owner.id
      user_sales5.role_id = role_sales.id
      user_sales5.save!

      user_sales6.account_id = account_owner.id
      user_sales6.role_id = role_sales.id
      user_sales6.save!
    end

    it 'should show user' do
      headers = { 'ACCEPT' => 'application/json',
                  'Authorization' => JsonWebToken.encode(user_id: user_owner.id) }
      params = { page: '1', items_per_page: '2', format: :json }
      get '/api/v1/users', params: params, headers: headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['data'][0]['attributes']['email']).to eq(user_owner.email)
      expect(json_response['data'].length).to eq(2)
      expect(json_response.dig('links', 'pagination', 'first_page_url')).not_to be_nil
      expect(json_response.dig('links', 'pagination', 'next_page_url')).not_to be_nil
      expect(json_response.dig('links', 'pagination', 'prev_page_url')).not_to be_nil
      expect(json_response.dig('links', 'pagination', 'links')).not_to be_nil
    end
  end
end
