require "rails_helper"

RSpec.describe "should create a new user", type: :request do
  before(:all) do
    @new_user = build(:user)
    @duplicate_user = build(:user)
  end
  describe "Registration" do
    it "should create a new user" do
      headers = { "ACCEPT" => "application/json" }
      post "/api/v1/users/registration", :params => {
                                           :user => {
                                             :email => @new_user.email,
                                             :password => "P4ssw0rd",
                                             :first_name => @new_user.first_name,
                                             :last_name => @new_user.last_name,
                                           },
                                         }
      expect(response).to have_http_status(:created)
      json_response = JSON.parse(response.body)
      expect(json_response["username"]).not_to be_nil
      expect(json_response["errors"]).to be_empty
    end

    #it "should not create duplicate user" do
    #  @duplicate_user.email = User.last.email
    #  headers = { "ACCEPT" => "application/json" }
    #  post "/api/users/v1/registration", params: {
    #                                       :user => {
    #                                         :email => @duplicate_user.email,
    #                                         :password => "P4ssw0rd",
    #                                         :first_name => @duplicate_user.first_name,
    #                                         :last_name => @duplicate_user.last_name,
    #                                       },
    #                                     }
    #  expect(response).to have_http_status(:unprocessable_entity)
    #  json_response = JSON.parse(response.body)
    #  expect(json_response["errors"]).not_to be_empty
    #end
  end
end
