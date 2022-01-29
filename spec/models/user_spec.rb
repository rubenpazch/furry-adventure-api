require "rails_helper"

RSpec.describe User, :type => :model do
  before(:all) do
    @user_valid = create(:user)
    @user_invalid_email = build(:user)
    @user_invalid_email_format = build(:user)
    @user_invalid_password = build(:user)
  end

  it "is has valid attributes" do
    expect(@user_valid).to be_valid
  end

  it "should return error message email is already taked" do
    @user_invalid_email.email = @user_valid.email
    @user_invalid_email.valid?
    #expect(@user_invalid_email).to be_invalid
    #expect(@user_invalid_email.errors[:email]).to be_truthy
    #expect(@user_invalid_email.errors.objects.first.full_message).to eq('Email has already been taken')
  end

  it "should return error message email has incorrect format" do 
    @user_invalid_email_format.email = "invalid.com"
    expect(@user_invalid_email_format).to be_invalid
    expect(@user_invalid_email.errors[:email]).to be_truthy
    expect(@user_invalid_email_format.errors.objects.first.full_message).to eq('Email has incorrect format')
  end

  it "should return error message password is required" do 
    @user_invalid_password.password_digest = ""
    expect(@user_invalid_password).to be_invalid
    expect(@user_invalid_password.errors[:password_digest].any?).to be_truthy
    expect(@user_invalid_password.errors.objects.first.full_message).to eq("Password digest can't be blank")
  end
  
  it "should return error message password is weak" do 
    @user_invalid_password.password_digest = "123456"
    expect(@user_invalid_password).to be_invalid
    expect(@user_invalid_password.errors.objects.first.full_message).to eq("Password digest is invalid")
  end

  it "should return error message password is valid" do 
    @user_invalid_password.password_digest = "123456abC."
    expect(@user_invalid_password).to be_valid
  end
end
