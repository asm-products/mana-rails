require 'rails_helper'

RSpec.describe Permission, :type => :model do
  let(:permission) { Permission.make! }
  let(:user) { User.make!(team: team) }
  let(:team) { Team.make! }
  it { should have_and_belong_to_many(:users) }

  it "is valid" do
    expect permission.valid?
  end

  describe "::for_everybody" do
    it "should contain permissions marked as public" do
      permission.update_attributes is_public: true
      expect(Permission.for_everybody).to include(permission)
    end
  end

  describe "#condition_hash" do
    before(:each) do
      permission.users << user
    end

    it "should return belongs_to_user hash" do
      permission.condition = "belongs_to_user"
      expect(permission.condition_hash(user)).to eq({id: user.id})
    end

    it "should return belongs_to_me hash" do
      permission.condition = "belongs_to_me"
      expect(permission.condition_hash(user)).to eq({user_id: user.id})
    end

    it "should return belongs_to_team hash" do
      permission.condition = "belongs_to_team"
      expect(permission.condition_hash(user)).to eq({team_id: user.team.id})
    end

    it "should return contact_belongs_to_team hash" do
      permission.condition = "contact_belongs_to_team"
      expect(permission.condition_hash(user)).to eq({ client: {team_id: user.team.id}})
    end
  end

  describe "::seed" do
    before(:each) do
      allow(Permission).to receive(:seed_data) do
       [{klass: 'Client', action: 'create', condition: 'belongs_to_team'},
        {klass: 'User', action: 'read', condition: 'belongs_to_team'}]
      end
    end

    it "should create the seeds" do
      expect {
        Permission.seed
      }.to change(Permission, :count).by(2)
    end

    it "should only create given klasses" do
      expect {
        Permission.seed(['User'])
      }.to change(Permission, :count).by(1)
      expect(Permission.first.klass).to eq('User')
    end

    it "should be idempotent" do
      Permission.seed
      expect {
        Permission.seed
      }.to_not change(Permission, :count)
    end
  end
end
