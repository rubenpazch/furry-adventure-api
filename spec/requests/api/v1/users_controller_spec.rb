require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
  context "GET /show" do
    let(:role_owner) { build(:role) }
    let(:user_valid) { build(:user) }
    let(:profile_owner) { create(:profile) }
    let(:valid_organization) { create(:organization) }
    let(:valid_account) { build(:account) }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!

      role_owner.account_id = valid_account.id
      role_owner.profile_id = profile_owner.id
      role_owner.save!

      user_valid.account_id = valid_account.id
      user_valid.role_id = role_owner.id
      user_valid.save!
    end

    it "should show user" do
      headers = { "ACCEPT" => "application/json",
                  "Authorization" => JsonWebToken.encode(user_id: user_valid.id) }
      get "/api/v1/users/#{user_valid.id}", :headers => headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["data"]["attributes"]["email"]).to eq(user_valid.email)
    end
  end

  context "POST /created" do
    let(:role_owner) { build(:role) }
    let(:profile_owner) { create(:profile) }
    let(:user_valid) { build(:user) }
    let(:valid_organization) { create(:organization) }
    let(:valid_account) { build(:account) }
    let(:existing_user_valid) { build(:user) }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!

      role_owner.account_id = valid_account.id
      role_owner.profile_id = profile_owner.id
      role_owner.save!

      #existing_user_valid.account_id = valid_account.id
      #existing_user_valid.role_id = role_owner.id
      #existing_user_valid.save!
    end

    it "should create a user" do
      headers = { "ACCEPT" => "application/json",
                  "Authorization" => JsonWebToken.encode(user_id: user_valid.id) }
      post "/api/v1/users", :params => {
                              :user => {
                                :email => user_valid.email,
                                :password => user_valid.password_digest,
                                :first_name => user_valid.first_name,
                                :last_name => user_valid.last_name,
                                :account_id => valid_account.id,
                                :role_id => role_owner.id,
                              },
                            }, :headers => headers, as: :json
      expect(response).to have_http_status(:created)
    end

    it "should not create user with taken email" do
      headers = { "ACCEPT" => "application/json",
                  "Authorization" => JsonWebToken.encode(user_id: user_valid.id) }
      post "/api/v1/users", :params => {
                              :user => {
                                :email => existing_user_valid.email,
                                :password => user_valid.password_digest,
                                :first_name => user_valid.first_name,
                                :last_name => user_valid.last_name,
                                :account_id => valid_account.id,
                              },
                            }, :headers => headers, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context "UPDATE /updated" do
    let(:role_owner) { build(:role) }
    let(:profile_owner) { create(:profile) }
    let(:valid_organization) { create(:organization) }
    let(:valid_account) { build(:account) }
    let(:existing_user_valid) { build(:user) }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!

      role_owner.account_id = valid_account.id
      role_owner.profile_id = profile_owner.id
      role_owner.save!

      existing_user_valid.account_id = valid_account.id
      existing_user_valid.role_id = role_owner.id
      existing_user_valid.save!
    end

    it "should update user with valid token" do
      updated_email = "testingemail@gmail.com"
      headers = {
        "ACCEPT" => "application/json",
        "Authorization" => JsonWebToken.encode(user_id: existing_user_valid.id),
      }
      patch "/api/v1/users/#{existing_user_valid.id}", :params => {
                                                         :user => {
                                                           :email => updated_email,
                                                         },
                                                       },
                                                       :headers => headers, as: :json
      expect(response).to have_http_status(:success)
    end

    it "should forbid update user without token" do
      updated_email = "testingemail@gmail.com"
      headers = {
        "ACCEPT" => "application/json",
      }
      patch "/api/v1/users/#{existing_user_valid.id}", :params => {
                                                         :user => {
                                                           :email => updated_email,
                                                         },
                                                       },
                                                       :headers => headers, as: :json
      expect(response).to have_http_status(:forbidden)
    end
  end

  context "DELETE /deleted" do
    let(:role_owner) { build(:role) }
    let(:profile_owner) { create(:profile) }
    let(:valid_organization) { create(:organization) }
    let(:valid_account) { build(:account) }
    let(:existing_user_valid) { build(:user) }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!

      role_owner.account_id = valid_account.id
      role_owner.profile_id = profile_owner.id
      role_owner.save!

      existing_user_valid.account_id = valid_account.id
      existing_user_valid.role_id = role_owner.id
      existing_user_valid.save!
    end

    it "should destroy user with valid token" do
      headers = {
        "ACCEPT" => "application/json",
        "Authorization" => JsonWebToken.encode(user_id: existing_user_valid.id),
      }
      delete "/api/v1/users/#{existing_user_valid.id}", :headers => headers, as: :json
      expect(response).to have_http_status(:no_content)
    end

    it "should destroy user with valid token" do
      headers = {
        "ACCEPT" => "application/json",
      }
      delete "/api/v1/users/#{existing_user_valid.id}", :headers => headers, as: :json
      expect(response).to have_http_status(:forbidden)
    end
  end

  context "GET /index" do
    let(:role_owner) { build(:role) }
    let(:role_sales) { build(:role) }
    let(:user_sales) { build(:user) }
    let(:user_sales1) { build(:user) }
    let(:user_sales2) { build(:user) }
    let(:user_sales3) { build(:user) }
    let(:user_sales4) { build(:user) }
    let(:user_sales5) { build(:user) }
    let(:user_sales6) { build(:user) }

    let(:user_owner) { build(:user) }
    let(:profile_owner) { create(:profile) }
    let(:profile_sales) { create(:profile) }
    let(:organization_owner) { create(:organization) }
    let(:account_owner) { build(:account) }

    before(:each) do
      account_owner.organizations_id = organization_owner.id
      account_owner.save!

      role_owner.account_id = account_owner.id
      role_owner.profile_id = profile_owner.id
      role_owner.save!

      role_sales.account_id = account_owner.id
      role_sales.profile_id = profile_sales.id
      role_sales.save!

      user_owner.account_id = account_owner.id
      user_owner.role_id = role_owner.id
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

    it "should show user" do
      headers = { "ACCEPT" => "application/json",
                  "Authorization" => JsonWebToken.encode(user_id: user_owner.id) }
      params = { :page => "1", :items_per_page => "2", format: :json }
      get "/api/v1/users", :params => params, :headers => headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["data"][0]["attributes"]["email"]).to eq(user_owner.email)
      expect(json_response["data"].length).to eq(2)
      expect(json_response.dig("links", "first")).not_to be_nil
      expect(json_response.dig("links", "last")).not_to be_nil
      expect(json_response.dig("links", "prev")).not_to be_nil
      expect(json_response.dig("links", "next")).not_to be_nil
    end
  end
end
