require 'rails_helper'

describe Client, :type => :model do
  before { @client = Client.make! }
  
  it "validates presence of name" do
    @client.name = nil
    expect @client.valid? == false
  end

end
