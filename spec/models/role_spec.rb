require 'rails_helper'

describe Role do
  it { should belong_to :team }
  it { should have_many :permissions }
  it { should have_and_belong_to_many(:memberships) }
end
