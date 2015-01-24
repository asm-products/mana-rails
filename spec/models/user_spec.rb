require 'rails_helper'

describe User, :type => :model do
  before do
   @user = User.make!
 end

  it { should have_and_belong_to_many(:permissions) }
  it { should have_and_belong_to_many(:roles) }
  it { should have_many(:memberships) }
  it { should have_many(:teams).through(:memberships) }

  describe "#current_team" do
    it "should save current_team" do
      team = Team.make!
      @user.current_team = team
      expect(@user.current_team).to eq(team)
    end

    it "should not persist" do
      @user.current_team = Team.make!
      expect(User.find(@user.id).current_team).to be_nil
    end
  end

  it "should set special_key" do
    expect(@user.special_key).to be_present
  end

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

  it "checks for a team" do
    expect @user.has_team?
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

  it "checks for admin" do
    @user.admin = true
    expect @user.admin?
  end

  it "revokes admin access" do
    @user.admin = true

    @user.revoke_admin
    expect !@user.admin?
  end

  it "revokes admin access and saves" do
    @user.admin = true

    @user.revoke_admin!
    expect !@user.admin?
  end

  it "adds admin access" do
    @user.admin = true

    @user.make_admin
    expect @user.admin?
  end

  it "adds admin access and saves" do
    @user.admin = true

    @user.make_admin!
    expect @user.admin?
  end

  it "belongs to a team" do
    expect @user.respond_to? :team
  end

end
