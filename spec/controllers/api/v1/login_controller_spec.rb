require "rails_helper"

RSpec.describe "should get JWT token", type: :request do
  before(:all) do
    @user1 = create(:user)
  end

  it "should get JWT token" do
    headers = { "ACCEPT" => "application/json" }
    post "/api/v1/login", :params => { :user => { :email => @user1.email, :password => "mystring" } }, :headers => headers
    expect(response).to have_http_status(:success)
  end
end
