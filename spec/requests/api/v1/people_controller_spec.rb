require "rails_helper"

RSpec.describe "Api::V1::People", type: :request do
  context "GET /show" do
    let(:person_one_bata) { build(:person) }
    let(:organization_bata) { create :organization }
    let(:account_bata) { build :account }
    let(:user_bata) { build(:user) }
    let(:profile_super_admin_bata) { create(:profile) }
    let(:role_super_admin_bata) { build(:role) }

    let(:organization_nike) { create :organization }
    let(:account_nike) { build :account }
    let(:profile_super_admin_nike) { create(:profile) }
    let(:role_super_admin_nike) { build(:role) }
    let(:user_nike) { build(:user) }

    before(:each) do
      account_bata.organizations_id = organization_bata.id
      account_bata.save!
      person_one_bata.account_id = account_bata.id
      person_one_bata.save!

      role_super_admin_bata.account_id = account_bata.id
      role_super_admin_bata.profile_id = profile_super_admin_bata.id
      role_super_admin_bata.save!

      user_bata.account_id = account_bata.id
      user_bata.role_id = role_super_admin_bata.id
      user_bata.save!

      account_nike.organizations_id = organization_nike.id
      account_nike.save!

      role_super_admin_nike.account_id = account_nike.id
      role_super_admin_nike.profile_id = profile_super_admin_nike.id
      role_super_admin_nike.save!

      user_nike.account_id = account_nike.id
      user_nike.role_id = role_super_admin_nike.id
      user_nike.save!
    end

    it "shuld show person" do
      headers = { "ACCEPT" => "application/json",
                  "Authorization" => JsonWebToken.encode(user_id: user_bata.id) }
      get "/api/v1/people/#{person_one_bata.id}", :headers => headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["data"]["attributes"]["first_name"]).to eq(person_one_bata.first_name)
    end

    it "shuold show forbidden when wrong user account" do
      headers = { "ACCEPT" => "application/json",
                  "Authorization" => JsonWebToken.encode(user_id: user_nike.id) }
      get "/api/v1/people/#{person_one_bata.id}", :headers => headers
      expect(response.status).to eql(403)
     end
  end
end
