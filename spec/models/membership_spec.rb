require 'rails_helper'

RSpec.describe Membership, :type => :model do
  it { should belong_to(:user) }
  it { should belong_to(:team) }
  it { should have_and_belong_to_many(:permissions) }
  it { should have_and_belong_to_many(:roles) }
end
