require 'rails_helper'

describe Project, :type => :model do
  before { @project = Project.make! }

  it { should validate_uniqueness_of(:short_code).scoped_to(:team_id) }

  it "is valid" do
    expect @project.valid?
  end

  it "only saves if client exists" do
    @project.client_id = 1000000004
    expect !@project.valid?
  end
  
  it "validates presence of name" do
    @project.name = nil
    expect !@project.valid?
  end

  it "has at least a 4 character name" do
    @project.name = "no"
    expect !@project.valid?
  end

  it "has at max a 4 character short code" do
    @project.short_code = "nonono"
    expect !@project.valid?
  end
  
  it "has a unique short code" do
    other_client = Project.make(short_code: @project.short_code)
    expect !other_client.valid?
  end

  it "has many issues" do
    expect(@project.issues).to be_a ActiveRecord::Associations::CollectionProxy
    expect(@project.issues.empty?).to eq true
  end

  it "belongs to a team" do
    expect @project.respond_to? :team
  end

  it "finds by short code" do
    expect Project.find_by_shortcode(@project.short_code)
  end

  it "finds by id" do
    expect Project.find_by_id(@project.id)
  end  

  it "has a short code alias" do
    expect @project.respond_to? :shortcode
  end
  
end
