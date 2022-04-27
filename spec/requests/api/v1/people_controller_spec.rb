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

    it "should show forbidden when not token" do
      headers = { "ACCEPT" => "application/json" }
      get "/api/v1/people/#{person_one_bata.id}", :headers => headers
      expect(response.status).to eql(403)
    end

    it "should show not found when not account user given" do
      headers = { "ACCEPT" => "application/json",
                  "Authorization" => JsonWebToken.encode(user_id: nil) }
      get "/api/v1/people/#{person_one_bata.id}", :headers => headers
      expect(response.status).to eql(404)
    end

    it "should show not found when not person given" do
      headers = { "ACCEPT" => "application/json",
                  "Authorization" => JsonWebToken.encode(user_id: user_nike.id) }
      get "/api/v1/people/999", :headers => headers
      expect(response.status).to eql(404)
    end
  end

  context "POST /create" do
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
      #person_one_bata.account_id = account_bata.id
      #person_one_bata.save!

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
      #user_nike.save!
    end

    it "should create a person" do
      headers = { "ACCEPT" => "application/json",
                  "Authorization" => JsonWebToken.encode(user_id: user_bata.id) }
      post "/api/v1/people", :params => {
                               :person => {
                                 :first_name => person_one_bata.first_name,
                                 :last_name => person_one_bata.last_name,
                                 :doc_id => person_one_bata.doc_id,
                                 :address => person_one_bata.address,
                                 :cell_phone => person_one_bata.cell_phone,
                                 :contact_phone => person_one_bata.contact_phone,
                                 :district => person_one_bata.district,
                                 :province => person_one_bata.province,
                                 :deparment => person_one_bata.deparment,
                                 :country => person_one_bata.country,
                                 :nationality => person_one_bata.nationality,
                                 :age => person_one_bata.age,
                                 :ocupation => person_one_bata.ocupation,
                                 :account_id => account_bata.id,
                               },
                             }, :headers => headers, as: :json
      expect(response).to have_http_status(:created)
    end

    it "should return record not found when not account given" do
      headers = { "ACCEPT" => "application/json",
                  "Authorization" => JsonWebToken.encode(user_id: user_bata.id) }
      post "/api/v1/people", :params => {
                               :person => {
                                 :first_name => person_one_bata.first_name,
                                 :last_name => person_one_bata.last_name,
                                 :doc_id => person_one_bata.doc_id,
                                 :address => person_one_bata.address,
                                 :cell_phone => person_one_bata.cell_phone,
                                 :contact_phone => person_one_bata.contact_phone,
                                 :district => person_one_bata.district,
                                 :province => person_one_bata.province,
                                 :deparment => person_one_bata.deparment,
                                 :country => person_one_bata.country,
                                 :nationality => person_one_bata.nationality,
                                 :age => person_one_bata.age,
                                 :ocupation => person_one_bata.ocupation,
                               },
                             }, :headers => headers, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
