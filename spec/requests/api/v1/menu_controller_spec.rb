require "rails_helper"

RSpec.describe "Api::V1::Menu", type: :request do
  context "GET /index" do
    let(:valid_role) { build(:role) }
    let(:valid_profile) { create(:profile) }
    let(:valid_account) { build :account }
    let(:valid_organization) { create :organization }
    let(:valid_user) { build :user }
    let(:menu1) { build :menus }
    let(:sub_menu11) { build :sub_menus }
    let(:sub_menu12) { build :sub_menus }
    let(:menu2) { build :menus }
    let(:sub_menu21) { build :sub_menus }
    let(:sub_menu22) { build :sub_menus }
    let(:menu_access_valid_user1) { build(:menu_accesses) }
    let(:menu_access_valid_user2) { build(:menu_accesses) }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!
      
      valid_role.account_id = valid_account.id
      valid_role.profile_id = valid_profile.id
      valid_role.save!

      valid_user.account_id = valid_account.id
      valid_user.role_id = valid_role.id
      valid_user.save!

      menu1.account_id = valid_account.id
      menu1.save!
      sub_menu11.menus_id = menu1.id
      sub_menu11.save!
      sub_menu12.menus_id = menu1.id
      sub_menu12.save!
      menu2.account_id = valid_account.id
      menu2.save!
      sub_menu21.menus_id = menu2.id
      sub_menu21.save!
      sub_menu22.menus_id = menu2.id
      sub_menu22.save!

      menu_access_valid_user1.menus_id = menu1.id
      menu_access_valid_user1.profile_id = valid_profile.id
      menu_access_valid_user1.save!

      menu_access_valid_user2.menus_id = menu1.id
      menu_access_valid_user2.profile_id = valid_profile.id
      menu_access_valid_user2.save!
    end

    it "should return list of menus" do
      headers = { "ACCEPT" => "application/json",
                  "Authorization" => JsonWebToken.encode(user_id: valid_user.id) }
      post "/api/v1/menu", headers: headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.dig("data").length).to eq(2)
      expect(json_response.dig("data")[0].dig("attributes", "title")).not_to be_nil
      expect(json_response.dig("data")[0].dig("attributes", "sub_menus").length).to eq(2)
    end
  end
end
