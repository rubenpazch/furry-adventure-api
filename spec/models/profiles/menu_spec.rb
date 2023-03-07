require 'rails_helper'

RSpec.describe Profiles::Menu, type: :model do
  context 'create admin menu' do
    let(:org_super_admin) { create(:organization) }
    let(:org_owner) { create(:organization) }

    let(:account_super_admin) { build(:account) }
    let(:account_owner) { build(:account) }

    let(:role_super_admin) { build(:role) }
    let(:role_owner) { build(:role) }
    let(:role_sales) { build(:role) }

    let(:menu_super_admin) { build(:menus) }
    let(:menu_owner) { build(:menus) }
    let(:menu_sales) { build(:menus) }

    let(:profile_super_admin) { create(:profile) }
    let(:profile_owner) { create(:profile) }
    let(:profile_sales) { create(:profile) }

    let(:menu_access_superadmin) { build(:menu_accesses) }
    let(:menu_access_superadmin_owner) { build(:menu_accesses) }
    let(:menu_access_superadmin_sales) { build(:menu_accesses) }

    let(:menu_access_owner) { build(:menu_accesses) }
    let(:menu_access_owner_sales) { build(:menu_accesses) }

    let(:menu_access_sales) { build(:menu_accesses) }

    before(:each) do
      account_super_admin.organizations_id = org_super_admin.id
      account_super_admin.save!

      role_super_admin.account_id = account_super_admin.id
      role_super_admin.profile_id = profile_super_admin.id
      role_super_admin.save!

      menu_super_admin.account_id = account_super_admin.id
      menu_super_admin.save!

      # owner
      account_owner.organizations_id = org_owner.id
      account_owner.save!

      menu_owner.account_id = account_owner.id
      menu_owner.save!

      menu_sales.account_id = account_owner.id
      menu_sales.save!

      role_owner.account_id = account_owner.id
      role_owner.profile_id = profile_owner.id
      role_owner.save!

      role_sales.account_id = account_owner.id
      role_sales.profile_id = profile_sales.id
      role_sales.save!
      # menu access -super admin
      menu_access_superadmin.menus_id = menu_super_admin.id
      menu_access_superadmin.profile_id = profile_super_admin.id
      menu_access_superadmin.save!

      menu_access_superadmin_owner.menus_id = menu_owner.id
      menu_access_superadmin_owner.profile_id = profile_super_admin.id
      menu_access_superadmin_owner.save!

      menu_access_superadmin_sales.menus_id = menu_sales.id
      menu_access_superadmin_sales.profile_id = profile_super_admin.id
      menu_access_superadmin_sales.save!
      # owner
      menu_access_owner.menus_id = menu_owner.id
      menu_access_owner.profile_id = profile_owner.id
      menu_access_owner.save!

      menu_access_owner_sales.menus_id = menu_sales.id
      menu_access_owner_sales.profile_id = profile_owner.id
      menu_access_owner_sales.save!
      # sales
      menu_access_sales.menus_id = menu_sales.id
      menu_access_sales.profile_id = profile_sales.id
      menu_access_sales.save!
    end

    it 'valid menu' do
      expect(menu_super_admin).to be_valid
    end

    it 'super admin menu' do
      expect(role_super_admin.profile.menus.length).to match(3)
    end

    it 'super admin menu' do
      expect(role_owner.profile.menus.length).to match(2)
    end

    it 'super admin menu' do
      expect(role_sales.profile.menus.length).to match(1)
    end
  end
end
