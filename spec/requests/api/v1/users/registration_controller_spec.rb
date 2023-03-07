require 'rails_helper'

RSpec.describe 'should create a new user', type: :request do
  let(:user_valid) { build(:user) }
  let(:valid_organization) { create(:organization) }
  let(:valid_account) { build(:account) }

  before(:each) do
    valid_account.organizations_id = valid_organization.id
    valid_account.save!
  end

  describe 'Registration' do
    it 'should create a new user' do
      headers = { 'ACCEPT' => 'application/json' }
      post '/api/v1/users/registration', params: {
        user: {
          email: user_valid.email,
          password: user_valid.password_digest,
          first_name: user_valid.first_name,
          last_name: user_valid.last_name,
          account_id: valid_account.id
        }
      }, headers: headers
      expect(response).to have_http_status(:created)
      json_response = JSON.parse(response.body)
      expect(json_response['username']).not_to be_nil
      expect(json_response['errors']).to be_empty
    end

    # it "should not create duplicate user" do
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
    # end
  end
end
