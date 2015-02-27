require 'rails_helper'

describe Profile, :type => :model do
  before { @user_profile = Profile.make! }

  it "is valid" do
    expect @user_profile.valid?
  end

  it "has an address" do
    expect @user_profile.respond_to? :address
  end

  it "has a secondary phone" do
    expect @user_profile.respond_to? :secondary_phone
  end

  it "has a time zone" do
    expect @user_profile.respond_to? :time_zone
  end

  it "has a twitter name" do
    expect @user_profile.respond_to? :twitter_name
  end

  it "belongs to a user" do
    expect @user_profile.respond_to? :user
  end  
  
end
