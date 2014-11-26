require 'rails_helper'

describe Issue, :type => :model do
  before { @issue = Issue.make! }

#  it "is valid" do
#    expect @issue.valid?
#  end
  
#  it "validates presence of subject" do
#    @issue.subject = nil
#    expect !@issue.valid?
#  end
end
