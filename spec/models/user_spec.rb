require "rails_helper"

RSpec.describe User, :type => :model do
  context "has valid user " do
    let(:user_valid) { build(:user) }
    let(:valid_organization) { create(:organization) }
    let(:valid_account) { build(:account) }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!
      user_valid.account_id = valid_account.id
    end

    it "is has valid attributes" do
      expect(user_valid).to be_valid
    end
  end
  context "has invalid user " do
    let(:user_valid) { build(:user) }
    let(:user_invalid_email) { build(:user) }
    let(:user_invalid_email_format) { build(:user) }
    let(:user_invalid_password) { build(:user) }
    let(:valid_organization) { create(:organization) }
    let(:valid_account) { build(:account) }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!
      user_valid.account_id = valid_account.id
      user_valid.save!
    end

    it "should return error message email is already taked" do
      user_invalid_email.email = user_valid.email
      user_invalid_email.valid?
      expect(user_invalid_email).to be_invalid
      expect(user_invalid_email.errors[:email]).to be_truthy
      expect(user_invalid_email.errors[:email].first).to eq("has already been taken")
    end

    it "should return error message email has incorrect format" do
      user_invalid_email_format.email = "invalid.com"
      user_invalid_email_format.valid?
      expect(user_invalid_email_format).to be_invalid
      expect(user_invalid_email_format.errors[:email]).to be_truthy
      expect(user_invalid_email_format.errors[:email].first).to eq("has incorrect format")
    end

    it "should return error message password is required" do
      user_invalid_password.password_digest = ""
      user_invalid_email_format.valid?
      expect(user_invalid_password).to be_invalid
      expect(user_invalid_password.errors[:password_digest].any?).to be_truthy
      expect(user_invalid_password.errors[:password_digest].first).to eq("can't be blank")
    end

    it "should return error message password is weak" do
      user_invalid_password.password_digest = "123456"
      user_invalid_email_format.valid?
      expect(user_invalid_password).to be_invalid
      expect(user_invalid_password.errors[:password_digest].first).to eq("is invalid")
    end
  end
end
