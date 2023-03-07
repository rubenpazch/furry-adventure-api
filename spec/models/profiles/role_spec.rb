require 'rails_helper'

RSpec.describe Profiles::Role, type: :model do
  context 'role creation' do
    let(:valid_organization) { create :organization }
    let(:valid_account) { build :account }
    let(:role_super_admin) { build :role }
    let(:role_doctor) { build :role }
    let(:role_assistant) { build :role }
    let(:super_admin) { create :profile }
    let(:owner) { create :profile }
    let(:seller) { create :profile }

    before(:each) do
      valid_account.organizations_id = valid_organization.id
      valid_account.save!
      role_super_admin.profile_id = super_admin
      role_super_admin.is_root = true
      role_super_admin.account_id = valid_account.id
      role_super_admin.save!
      # doctor
      role_doctor.profile_id = owner.id
      role_doctor.parent_id = role_super_admin.id
      role_doctor.account_id = valid_account.id
      role_doctor.save!
      # seller
      role_assistant.profile_id = seller.id
      role_assistant.parent_id = role_super_admin.id
      role_assistant.account_id = valid_account.id
      role_assistant.save!
    end
    describe 'a super admin' do
      it 'is a root role' do
        expect(role_super_admin.is_root).to be_truthy
      end

      it 'is a parent role' do
        expect(role_super_admin.parent_id).to match(0)
      end
    end

    describe 'a doctor' do
      it 'has a valid role' do
        expect(role_doctor.is_root).to be_falsey
      end

      it 'has super admin as parent' do
        expect(role_doctor.parent_id).to eql(role_super_admin.id)
      end
    end

    describe 'a assisstant' do
      it 'has a valid role' do
        expect(role_assistant.is_root).to be_falsey
      end

      it 'has super admin as parent' do
        expect(role_assistant.parent_id).to eql(role_super_admin.id)
      end
    end
  end
end
