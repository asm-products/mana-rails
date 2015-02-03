require "rails_helper"

describe ProjectsController do
  context "logged in" do
    before(:each) do
      login
      Permission.seed("Project")
      Membership.all.each do |member|
        member.permissions << Permission.all
      end
    end

    def create_project
      visit projects_path
      click_link 'Create New Project'
      fill_in :project_name, with: "testproject"
      click_on "Create Project"
    end

    it "should create project" do
      create_project

      expect(page).to have_content('Project Created!')
      expect(page).to have_content('testproject')
    end

    it "should list projects" do
      create_project

      visit projects_path
      expect(page).to have_content('testproject')
    end

    it "should not see other teams projects" do
      team = Team.make!
      project = Project.make!(team: team)

      visit projects_path
      expect(page).to_not have_content(project.name)

      visit project_path(project)
      expect(page).to_not have_content(project.name)
    end
  end

  context "not logged in" do
    it "should not see projects list" do
      visit projects_path
      expect(page.current_path).to eq(login_path)
    end

    it "should not see project" do
      visit client_path(Project.make!)
      expect(page.current_path).to eq(login_path)
    end
  end
end
