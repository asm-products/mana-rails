require "rails_helper"

describe ProjectsController do
  context "logged in" do
    before(:each) do
      login
    end

    def create_project
      visit projects_path
      click_link 'Create New Project'
      fill_in :project_name, with: "testproject"
      click_on "Create Project"
    end

    it "should create client" do
      create_project

      expect(page).to have_content('Project Created!')
      expect(page).to have_content('testproject')
    end

    it "should list projects" do
      create_project

      visit projects_path
      expect(page).to have_content('testproject')
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
