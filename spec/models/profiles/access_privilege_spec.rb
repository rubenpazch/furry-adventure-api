# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profiles::AccessPrivilege, type: :model do
  context 'access privilege creation' do
    let(:manage_users_super_admin) { build :access_privilege }
    let(:manage_users_super_admin_create) { build :access_privilege }
    let(:manage_users_super_admin_update) { build :access_privilege }
    let(:manage_users_super_admin) { build :access_privilege }

    let(:super_admin) { create :profile }
    let(:manage_users) { create :privilege }
    let(:manage_users_create) { create :privilege }
    let(:manage_users_update) { create :privilege }

    before(:each) do
      manage_users_super_admin.profile_id = super_admin.id
      manage_users_super_admin.privilege_id = manage_users.id
      manage_users_super_admin.save!
      # create
      manage_users_super_admin_create.profile_id = super_admin.id
      manage_users_super_admin_create.privilege_id = manage_users_create.id
      manage_users_super_admin_create.save!
      # update
      manage_users_super_admin_update.profile_id = super_admin.id
      manage_users_super_admin_update.privilege_id = manage_users_update.id
      manage_users_super_admin_update.save!
    end

    describe 'super admin user' do
      it 'valid access privilege to manage users' do
        expect(manage_users_super_admin).to be_valid
        expect(manage_users_super_admin_create).to be_valid
        expect(manage_users_super_admin_update).to be_valid
      end
    end
  end
end
