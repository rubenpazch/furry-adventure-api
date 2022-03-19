require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
  context "GET /index" do
    let(:user_valid) { build(:user) }
    let(:valid_organization) { create(:organization) }
    let(:valid_account) { build(:account) }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!
      user_valid.account_id = valid_account.id
      user_valid.save!
    end

    it "should show user" do
      headers = { "ACCEPT" => "application/json" }
      get "/api/v1/users/#{user_valid.id}"
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["id"]).to equal(user_valid.id)
    end
  end

  context "POST /created" do
    let(:user_valid) { build(:user) }
    let(:valid_organization) { create(:organization) }
    let(:valid_account) { build(:account) }
    let(:existing_user_valid) { build(:user) }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!
      existing_user_valid.account_id = valid_account.id
      existing_user_valid.save!
    end

    it "should create a user" do
      headers = { "ACCEPT" => "application/json" }
      post "/api/v1/users", :params => {
                              :user => {
                                :email => user_valid.email,
                                :password => user_valid.password_digest,
                                :first_name => user_valid.first_name,
                                :last_name => user_valid.last_name,
                                :account_id => valid_account.id,
                              },
                            }, :headers => headers, as: :json
      expect(response).to have_http_status(:created)
    end

    it "should not create user with taken email" do
      headers = { "ACCEPT" => "application/json" }
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
    let(:valid_organization) { create(:organization) }
    let(:valid_account) { build(:account) }
    let(:existing_user_valid) { build(:user) }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!
      existing_user_valid.account_id = valid_account.id
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
    let(:valid_organization) { create(:organization) }
    let(:valid_account) { build(:account) }
    let(:existing_user_valid) { build(:user) }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!
      existing_user_valid.account_id = valid_account.id
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
end
