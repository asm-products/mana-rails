require 'rails_helper'

describe Ability do
  let(:membership) { Membership.make! }
  let(:user) { membership.user }

  before(:each) do
    user.current_membership = membership
    user.current_team = membership.team
  end

  context "Contact" do
    let(:contact) { Contact.make! }
    before(:each) do
      Permission.seed("Contact")
      membership.permissions << Permission.all
      @ability = Ability.new(user)
    end

    it "should read contacts in team" do
      client = contact.client
      client.team = membership.team
      client.save

      expect(@ability.can? :read, contact).to be(true)
    end

    it "should not read contacts in team" do
      contact.client.update_attributes team_id: Team.make!.id
      expect(@ability.can? :read, contact).to be(false)
    end
  end


end
