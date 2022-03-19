require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
  let(:user) { create :user }
  let(:userTwo) { create :user }
  let(:userThree) { create :user }

  context "GET /index" do
    it "should show user" do
      headers = { "ACCEPT" => "application/json" }
      get "/api/v1/users/#{user.id}"
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["id"]).to equal(1)
    end
  end

  context "POST /created" do
    it "should create a user" do
      headers = { "ACCEPT" => "application/json" }
      post "/api/v1/users", :params => {
                              :user => {
                                :email => "testingNew@gmail.com",
                                :password => "123456",
                                :first_name => "aleatory firstname",
                                :last_name => "aleatoryy lastname",
                              },
                            }, :headers => headers, as: :json
      expect(response).to have_http_status(:created)
    end

    it "should not create user with taken email" do
      headers = { "ACCEPT" => "application/json" }
      post "/api/v1/users", :params => {
                              :user => {
                                :email => user.email,
                                :password => "123456",
                                :first_name => "aleatory firstname",
                                :last_name => "aleatoryy lastname",
                              },
                            }, :headers => headers, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context "UPDATE /updated" do
    it "should update user with valid token" do
      updated_email = "testingemail@gmail.com"
      headers = {
        "ACCEPT" => "application/json",
        "Authorization" => JsonWebToken.encode(user_id: userTwo.id),
      }
      patch "/api/v1/users/#{userTwo.id}", :params => {
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
      patch "/api/v1/users/#{userTwo.id}", :params => {
                                             :user => {
                                               :email => updated_email,
                                             },
                                           },
                                           :headers => headers, as: :json
      expect(response).to have_http_status(:forbidden)
    end
  end

  context "DELETE /deleted" do
    it "should destroy user with valid token" do
      headers = {
        "ACCEPT" => "application/json",
        "Authorization" => JsonWebToken.encode(user_id: userThree.id),
      }
      delete "/api/v1/users/#{userThree.id}", :headers => headers, as: :json
      expect(response).to have_http_status(:no_content)
    end

    it "should destroy user with valid token" do
      headers = {
        "ACCEPT" => "application/json",
      }
      delete "/api/v1/users/#{userThree.id}", :headers => headers, as: :json
      expect(response).to have_http_status(:forbidden)
    end
  end
end
