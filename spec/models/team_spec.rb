require 'rails_helper'

RSpec.describe Team, :type => :model do
  it { should have_many :roles }
  it { should have_many :memberships}
  it { should have_many(:users).through(:memberships)}

  before { @team = Team.make! }

  describe "#slug" do
    it "should remove all non alphanumeric characters and downcase" do
      team = Team.make!(name: "AsDf & / ( ) = 123   -?=")
      expect(team.slug).to eq("asdf123")
    end

    it "should generate different slugs for same name" do
      Team.make!(name: "test")
      expect(Team.make!(name: "test").slug).to eq("test1")
    end
  end

  it "is valid" do
    expect @team.valid?
  end

  it "has a name" do
    @team.name = nil
    expect !@team.valid?
  end

  it "sets a name" do
    @team.set_name("New Name")
    expect @team.name == "New Name"
  end

  it "sets a name and saves" do
    @team.set_name!("New Name")
    expect Team.find(@team.id).name == "New Name"
  end

  it "Adds Users" do
    user = User.make!(name: "TestName2", email: "test2@test2.com")
    @team.add_user(user)

    expect @team.has_user? user
  end

  it "Adds Users" do
    user = User.make!(name: "TestName2", email: "test2@test2.com")
    @team.add_user!(user)

    expect Team.find(@team.id).has_user? user
  end
end
