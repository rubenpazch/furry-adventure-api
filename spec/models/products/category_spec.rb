require "rails_helper"

RSpec.describe Products::Category, type: :model do
  let(:valid_category) { build :products_category }
  let(:valid_organization) { create(:organization) }
  let(:valid_account) { build(:account) }

  before(:each) do
    valid_account.organizations_id = valid_organization.id
    valid_account.save!
  end

  context "Valid category" do
    it "with slug to be equal compared with title" do
      valid_category.account_id = valid_account.id
      expect(valid_category).to be_valid
      valid_category.save!
    end
  end

  context "Invalid category" do
    it "with slug to be different compared with title" do
      array_items = valid_category.title.split(" ")
      array_items[2] = "test"
      valid_category.account_id = valid_account.id
      valid_category.title = array_items.join("-")
      expect(valid_category).to be_invalid
    end
  end
end
