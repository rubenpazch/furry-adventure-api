require 'rails_helper'

RSpec.describe User, type: :model do
  context 'has valid user ' do
    let(:user_valid) { build(:user) }
    let(:valid_organization) { create(:organization) }
    let(:valid_account) { build(:account) }

    let(:profile_super_admin) { create(:profile) }
    let(:role_super_admin) { build(:role) }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!

      role_super_admin.account_id = valid_account.id
      role_super_admin.profile_id = profile_super_admin.id
      role_super_admin.save!

      user_valid.account_id = valid_account.id
      user_valid.role_id = role_super_admin.id
      user_valid.save!
    end

    it 'is has valid attributes' do
      expect(user_valid).to be_valid
    end
  end
  context 'has invalid user ' do
    let(:user_valid) { build(:user) }
    let(:user_invalid_email) { build(:user) }
    let(:user_invalid_email_format) { build(:user) }
    let(:user_invalid_password) { build(:user) }
    let(:valid_organization) { create(:organization) }
    let(:valid_account) { build(:account) }

    let(:profile_super_admin) { create(:profile) }
    let(:role_super_admin) { build(:role) }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!

      role_super_admin.account_id = valid_account.id
      role_super_admin.profile_id = profile_super_admin.id
      role_super_admin.save!

      user_valid.account_id = valid_account.id
      user_valid.role_id = role_super_admin.id
      user_valid.save!
    end

    it 'should return error message email is already taked' do
      user_invalid_email.email = user_valid.email
      user_invalid_email.valid?
      expect(user_invalid_email).to be_invalid
      expect(user_invalid_email.errors[:email]).to be_truthy
      expect(user_invalid_email.errors[:email].first).to eq('has already been taken')
    end

    it 'should return error message email has incorrect format' do
      user_invalid_email_format.email = 'invalid.com'
      user_invalid_email_format.valid?
      expect(user_invalid_email_format).to be_invalid
      expect(user_invalid_email_format.errors[:email]).to be_truthy
      expect(user_invalid_email_format.errors[:email].first).to eq('has incorrect format')
    end

    it 'should return error message password is required' do
      user_invalid_password.password_digest = ''
      user_invalid_email_format.valid?
      expect(user_invalid_password).to be_invalid
      expect(user_invalid_password.errors[:password_digest].any?).to be_truthy
      expect(user_invalid_password.errors[:password_digest].first).to eq("can't be blank")
    end

    it 'should return error message password is weak' do
      user_invalid_password.password_digest = '123456'
      user_invalid_email_format.valid?
      expect(user_invalid_password).to be_invalid
      expect(user_invalid_password.errors[:password_digest].first).to eq('is invalid')
    end
  end
  context 'list users by account' do
    let(:user_one_admin) { build(:user) }
    let(:user_one_owner) { build(:user) }
    let(:user_one_sales) { build(:user) }
    let(:user_two_admin) { build(:user) }
    let(:user_two_owner) { build(:user) }
    let(:user_two_sales) { build(:user) }

    let(:profile_super_admin_one) { create(:profile) }
    let(:role_super_admin_one) { build(:role) }

    let(:profile_super_admin_two) { create(:profile) }
    let(:role_super_admin_two) { build(:role) }

    let(:organization_one) { create(:organization) }
    let(:organization_two) { create(:organization) }
    let(:account_one) { build(:account) }
    let(:account_two) { build(:account) }

    before(:each) do
      account_one.organizations_id = organization_one.id
      account_one.save!

      role_super_admin_one.account_id = account_one.id
      role_super_admin_one.profile_id = profile_super_admin_one.id
      role_super_admin_one.save!

      user_one_admin.account_id = account_one.id
      user_one_admin.role_id = role_super_admin_one.id
      user_one_admin.save!
      user_one_owner.account_id = account_one.id
      user_one_owner.role_id = role_super_admin_one.id
      user_one_owner.save!
      user_one_sales.account_id = account_one.id
      user_one_sales.role_id = role_super_admin_one.id
      user_one_sales.save!

      account_two.organizations_id = organization_two.id
      account_two.save!

      role_super_admin_two.account_id = account_two.id
      role_super_admin_two.profile_id = profile_super_admin_two.id
      role_super_admin_two.save!

      user_two_admin.account_id = account_two.id
      user_two_admin.role_id = role_super_admin_two.id
      user_two_admin.save!
      user_two_owner.account_id = account_two.id
      user_two_owner.role_id = role_super_admin_two.id
      user_two_owner.save!
      user_two_sales.account_id = account_two.id
      user_two_sales.role_id = role_super_admin_two.id
      user_two_sales.save!
    end

    it 'should return a list of users by account one' do
      expect(User.users_by_account(account_one.id).length).to match(3)
    end

    it 'should return a list of users by account one' do
      expect(User.users_by_account(account_two.id).length).to match(3)
    end
  end

  describe 'validations' do
    describe 'email format validation' do
      it 'accepts a valid email' do
        subject.email = 'foo@bar.com'
        subject.valid?
        binding.pry
        expect(subject.errors[:email].length).to eq 0
      end

      it 'accepts a nil email' do
        subject.email = nil
        subject.valid?
        expect(subject.errors[:email].length).to eq 0
      end
    end
  end
end
