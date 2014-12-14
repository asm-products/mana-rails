require 'rails_helper'

describe Client, :type => :model do
  before { @client = Client.make! }

  it "is valid" do
    expect @client.valid?
  end
  
  it "validates presence of name" do
    @client.name = nil
    expect !@client.valid?
  end

  it "has at least a 4 character name" do
    @client.name = "no"
    expect !@client.valid?
  end

  it "has at least a 4 character short code" do
    @client.short_code = "no"
    expect !@client.valid?
  end
  
  it "has at max a 6 character short code" do
    @client.short_code = "nononono"
    expect !@client.valid?
  end

  it "has a unique short code" do
      other_client = Client.make(short_code: @client.short_code)
    expect !other_client.valid?
  end
  
  it "has valid phone number" do
    other_client = Client.make(phone: "123456789")
    expect !other_client.valid?
  end
  
  it "allows blank phone number" do
    other_client = Client.make(phone: "")
    expect other_client.valid?
  end
  
  it "normalizes phone number" do
    other_client = Client.make(phone: "(123)456-7890")
    expect other_client.valid?
  end 

  it "belongs to a team" do
    expect @client.respond_to? :team
  end 
end
