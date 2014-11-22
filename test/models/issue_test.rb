require 'test_helper'

class IssueTest < ActiveSupport::TestCase
  test "requires a subject" do
    assert Issue.new(subject: nil).save == false
  end

  test "projected_hours defaults to 0.0" do
    assert Issue.create().projected_hours == 0.0
    assert Issue.create(projected_hours: 10.0).projected_hours == 10.0
  end
end
