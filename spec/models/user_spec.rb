require 'rails_helper'

describe User, :type => :model do
  before { @user = User.make! }

  it "is valid" do
    expect @user.valid?
  end

  it "validates presence of name" do
    @user.name = nil
    expect !@user.valid?
  end

  it "has at max a 50 character name" do
    50.times { @user.name += "a" }
    expect !@user.valid?
  end

  it "validates presence of email" do
    @user.email = nil
    expect !@user.valid?
  end

  it "validates length of email" do
    255.times { @user.email += "m" }
    expect !@user.valid?
  end

  it "validates format of email" do
    @user.email = "testtest.com"
    expect !@user.valid?
  end

  it "validates length of password" do
    @user.password = "123"
    expect !@user.valid?
  end
end
