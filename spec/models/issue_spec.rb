require 'rails_helper'

describe Issue, :type => :model do
  before { @issue = Issue.make! }

  it "is valid" do
    expect @issue.valid?
  end
  
  it "validates presence of subject" do
    @issue.subject = nil
    expect !@issue.valid?
  end

  it "validates length of subject" do
    @issue.subject = "no"
    expect !@issue.valid?
  end

  it "validates presence of project_id" do
    @issue.project_id = nil
    expect !@issue.valid?
  end

  it "sets unique_id" do
    expect(@issue.unique_id).to eq(1)
  end  

  it "belongs to a team" do
    expect @issue.respond_to? :team
  end 
end
