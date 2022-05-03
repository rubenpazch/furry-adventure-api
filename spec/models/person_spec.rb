require "rails_helper"

RSpec.describe Person, type: :model do
  context "create" do
    let(:person_one) { build(:person) }
    let(:valid_organization) { create :organization }
    let(:valid_account) { build :account }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!
    end

    it "a new person" do
      expect(person_one).to be_invalid
    end

    it "is a valid person" do
      person_one.account_id = valid_account.id
      expect(person_one).to be_valid
    end

    it "is saved" do 
      person_one.account_id = valid_account.id
      person_one.save!
      expect(Person.first.first_name).to eql(person_one.first_name)
    end
  end
end
