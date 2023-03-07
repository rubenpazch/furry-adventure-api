# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profiles::SubMenu, type: :model do
  context 'create sub-menu' do
    let(:valid_menu_admin) { build(:sub_menus) }
    let(:valid_menu_owner) { build(:sub_menus) }
    let(:valid_menu_sales) { build(:sub_menus) }

    before(:each) do
      valid_menu_admin.save!
    end

    skip 'valid sub-menu' do
    end
  end
end
