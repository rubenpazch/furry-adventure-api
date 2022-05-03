require "rails_helper"

RSpec.describe "should get JWT token", type: :request do
  let(:valid_organization) { create(:organization) }
  let(:valid_account) { build(:account) }
  let(:existing_user_valid) { build(:user) }

  before(:each) do
    valid_account.organizations_id = valid_organization.id
    valid_account.save!
    existing_user_valid.account_id = valid_account.id
    existing_user_valid.save!
  end

  skip "should get JWT token" do
    headers = { "ACCEPT" => "application/json" }
    post "/api/v1/login", :params => {
                            :user => {
                              :email => existing_user_valid.email,
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
