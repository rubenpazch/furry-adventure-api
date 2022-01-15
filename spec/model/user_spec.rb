require "rails_helper"

RSpec.describe User, :type => :model do
  before(:all) do
    @user1 = create(:user)
    @user2 = build(:user)
  end

  it "is has valid attributes" do
    expect(@user1).to be_valid
  end

  it "email is already taked" do
    @user2.email = @user1.email
    @user2.valid?
    expect(@user2).to be_invalid
  end
end
