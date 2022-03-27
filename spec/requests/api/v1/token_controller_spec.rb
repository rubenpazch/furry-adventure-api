require "rails_helper"

RSpec.describe "should get JWT token", type: :request do
  context "GET /verify" do
    let(:valid_organization) { create(:organization) }
    let(:valid_account) { build(:account) }
    let(:existing_user_valid) { build(:user) }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!
      existing_user_valid.account_id = valid_account.id
      existing_user_valid.save!
    end

    it "should get the user params" do
      @token = "Bearer " + JsonWebToken.encode(user_id: existing_user_valid.id)

      headers = {
        "ACCEPT" => "application/json",
        "Authorization" => @token,
      }
      post "/api/v1/tokens", headers: headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["username"]).not_to be_nil
      expect(json_response["token"]).not_to be_nil
      expect(json_response["username"]).to eq(existing_user_valid.email)
    end
  end
end
