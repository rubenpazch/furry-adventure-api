require "rails_helper"

RSpec.describe "should get JWT token", type: :request do
  context "GET /verify" do
    let(:valid_organization) { create(:organization) }
    let(:valid_account) { build(:account) }
    let(:valid_role) { build(:role) }
    let(:existing_user_valid) { build(:user) }
    let(:super_admin) { create(:profile) }
    let(:owner) { create(:profile) }
    let(:sales) { create(:profile) }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!
      valid_role.account_id = valid_account.id
      valid_role.profile_id = super_admin.id
      valid_role.save!
      existing_user_valid.account_id = valid_account.id
      existing_user_valid.role_id = valid_role.id
      existing_user_valid.save!
    end

    it "should get the user params" do
      @token = "Bearer " + JsonWebToken.encode(user_id: existing_user_valid.id)

      headers = {
        "ACCEPT" => "application/json",
        "Authorization" => @token,
      }
      get "/api/v1/tokens", headers: headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["username"]).not_to be_nil
      expect(json_response["token"]).not_to be_nil
      expect(json_response["username"]).to eq(existing_user_valid.email)
    end
  end
end
