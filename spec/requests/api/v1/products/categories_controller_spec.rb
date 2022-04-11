require "rails_helper"

RSpec.describe "Api::V1::Products::Categories", type: :request do
  context "GET /index" do
    let(:valid_role) { build(:role) }
    let(:valid_role_two) { build(:role) }
    
    let(:valid_profile) { create(:profile) }
    let(:valid_profile_two) { create(:profile) }
    
    let(:valid_category) { build(:products_category) }
    let(:valid_category_image) { build(:product_category_images) }
    
    let(:valid_category_two) { build(:products_category) }
    let(:valid_category_image_two) { build(:product_category_images) }

    let(:valid_account) { build :account }
    let(:valid_account_two) { build :account }
    
    let(:valid_organization) { create :organization }
    let(:valid_organization_two) { create :organization }
    
    let(:valid_user) { build :user }
    let(:valid_user_two) { build :user }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!

      valid_role.account_id = valid_account.id
      valid_role.profile_id = valid_profile.id
      valid_role.save!

      valid_user.account_id = valid_account.id
      valid_user.role_id = valid_role.id
      valid_user.save!
      
      valid_category.account_id = valid_account.id
      valid_category.save!
      valid_category_image.product_categories_id = valid_category.id
      valid_category_image.save!

      valid_account_two.organizations_id = valid_organization_two.id
      valid_account_two.save!

      valid_role_two.account_id = valid_account_two.id
      valid_role_two.profile_id = valid_profile_two.id
      valid_role_two.save!
      
      valid_user_two.account_id = valid_account_two.id
      valid_user_two.role_id = valid_role_two.id
      valid_user_two.save!
      
      valid_category_two.account_id = valid_user_two.id
      valid_category_two.save!
      valid_category_image_two.product_categories_id = valid_category_two.id
      valid_category_image_two.save!
    end

    it "should return a list of categories" do
      headers = { "ACCEPT" => "application/json",
                  "Authorization" => JsonWebToken.encode(user_id: valid_user.id) }
      get "/api/v1/products/categories", headers: headers
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['data'].length).to match(1)
      expect(json_response['included'].length).to match(1)
    end
  end
end
