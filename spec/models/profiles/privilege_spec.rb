# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profiles::Privilege, type: :model do
  context 'privilege creation' do
    let(:manage_users) { create :privilege }
    let(:manage_users_sub_item_one) { create :privilege }
    let(:manage_users_sub_item_two) { create :privilege }

    describe 'user management' do
      it 'has a valid privilege' do
        expect(manage_users).to be_valid
      end

      it 'has a valid privilege' do
        expect(manage_users_sub_item_one).to be_valid
      end

      it 'has a valid privilege' do
        expect(manage_users_sub_item_two).to be_valid
      end
    end
  end
end
