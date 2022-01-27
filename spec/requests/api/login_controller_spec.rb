require "rails_helper"

RSpec.describe "should get JWT token", type: :request do
  before(:all) do
    @user1 = create(:user)
  end

  it "should get JWT token" do
    headers = { "ACCEPT" => "application/json" }
    post "/api/v1/login", :params => {
                            :user => {
                              :email => @user1.email,
                              :password => "MyString",
                            },
                          },
                          :headers => headers
    expect(response).to have_http_status(:success)
    json_response = JSON.parse(response.body)
    expect(json_response["token"]).not_to be_nil
    expect(json_response["username"]).not_to be_nil
  end
end
