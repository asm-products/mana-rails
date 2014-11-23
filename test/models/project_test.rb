require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup
    @client = Client.create(name: "Test Client", short_code: "must have something here")
    @project = Project.new(name: "Test Project", short_code: "", client_id: @client.id)
  end

  test "should be valid" do
    assert @project.valid?
  end

  test "should only save with client_id if client exists" do
    @project.client_id = "100000000"
    assert_not @project.valid?
  end  
  
  test "requres at max 4 character short code" do
    @project.short_code = "blahblah"
    assert_not @project.valid? 
  end

  test "allows blank short code" do
    @project.short_code = ""
    assert @project.valid? 
  end

  test "requres name" do
    @project.name = nil
    assert_not @project.valid? 
  end

  test "requres at least 4 character name" do
    @project.name = "no"
    assert_not @project.valid? 
  end
end
