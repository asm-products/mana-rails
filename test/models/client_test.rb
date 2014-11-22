require 'test_helper'

class ClientTest < ActiveSupport::TestCase

  def setup
    @client = Client.new(name: "Test Client", short_code: "")
  end

  test "should be valid" do
    assert @client.valid?
  end  
  
  test "requres at least 4 character short code" do
    @client.short_code = "no"
    assert_not @client.valid? 
  end

  test "requres a maximum 6 character short code" do
    @client.short_code = "this code is too long"
    assert_not @client.valid? 
  end

  test "requres a 4 to 6 character short code" do
    @client.short_code = "12345"
    assert @client.valid? 
  end  

  test "allows blank short code" do
    @client.short_code = ""
    assert @client.valid? 
  end

  test "requres name" do
    @client.name = nil
    assert_not @client.valid? 
  end

  test "requres at least 4 character name" do
    @client.name = "no"
    assert_not @client.valid? 
  end
end
