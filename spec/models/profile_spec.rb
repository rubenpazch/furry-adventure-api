require "rails_helper"

RSpec.describe Profile, type: :model do
  context "Super Admin" do
    let(:super_admin) { create :profile }

    it "has super admin valid profile" do
      expect(super_admin).to be_valid
    end
  end

  context "Admin" do
    let(:admin) { create :profile }

    it "has super admin valid profile" do
      expect(admin).to be_valid
    end
  end

  context "Owner" do
    let(:owner) { create :profile }

    it "has super admin valid profile" do
      expect(owner).to be_valid
    end
  end

  context "Seller" do
    let(:seller) { create :profile }

    it "has super admin valid profile" do
      expect(seller).to be_valid
    end
  end
end
