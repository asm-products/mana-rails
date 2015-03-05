require 'rails_helper'

RSpec.describe ContactsController, :type => :controller do
	before do
		login
		@request.host = "#{current_team.slug}.example.com"
		@contact = Contact.make!
		@client = @contact.client
	end
	
	context "with all permissions" do
		before do
			current_user.current_membership.permissions << Permission.make!(action: 'manage', klass: 'Contact')
		end
		
		it "creates contact without profile" do
			post :create, { client_id: @client.short_code }, contact: { email:"contact_test@example.com" }
			
			expect(response).to_not render_template :new
			expect(response).to render_template nil
		end
		
		it "creates contact with profile" do
			post :create, { client_id: @client.short_code }, 
				contact: { email: "contact_test@example.com" }, 
				profile: {first_name: "Test", last_name: "McTest", job_title: "Tester", phone: "1234567890"} 
		
			expect(response).to_not render_template :new
			expect(response).to render_template nil
		end
		
		#TODO: write more client specs.
	end
end
