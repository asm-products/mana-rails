# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#---------------------------------------
# Dummy data for development environment
#---------------------------------------
if Rails.env.development?
  team = Team.create(name:'TestTeam')
  user_1 = User.create(name: 'user', email: 'user@manaapp.com', password: 'password', password_confirmation: 'password', team_id: team.id)
  user_2 = User.create(name: 'admin', email:'admin@manaapp.com', password: 'password', password_confirmation: 'password', team_id: team.id)
  UserProfile.create(first_name: 'Test', last_name: 'User', job_title: 'Normal User', phone: '1234567890', user: user_1)
  UserProfile.create(first_name: 'Test', last_name: 'Admin', job_title: 'Admin User', phone: '1234567890', user: user_2)
  client_1 = Client.create(name: 'Cool Stuff Inc.', address: '9000 Coolio Dr. San Antonio, Texas 78238 United States', phone: '8008675309', website: 'www.cool.com', short_code:'COOL', team_id: team.id)
  client_2 = Client.create(name: 'Cooperate Cooperation', address: '90210 Bevelry Blvd. San Antonio, Texas 78238 United States', phone: '8002221111', website: 'www.corp.com', short_code: 'CORP', team_id: team.id)
  client_3 = Client.create(name: 'Startups Inc.', address: '800 Somewhere Dr. Cupertino, California 95014 United States', phone: '1234567890', website: 'www.startup.com', short_code: 'STAR', team_id: team.id)
  Comment.create(body: 'This is a client note', commenter: user_1, commentable: client_1)
  client_1_contact_1 = Contact.create(name: 'bobnarley', email: 'bobnarley@cool.com', password: 'password', password_confirmation: 'password', client: client_1)
  UserProfile.create(first_name: 'Robert', last_name: 'Narley', job_title: 'Owner', phone: '8008675309', user: client_1_contact_1)
  client_1_contact_2 = Contact.create(name: 'sandynarley', email: 'sandynarley@cool.com', password: 'password', password_confirmation: 'password', client: client_1)
  UserProfile.create(first_name: 'Sandy', last_name: 'Narley', job_title: 'Vice President', phone: '8008675310', user: client_1_contact_2)
  client_2_contact_1 = Contact.create(name: 'thelumbergh', email: 'bill.lumbergh@corp.com', password: 'password', password_confirmation: 'password', client: client_2)
  UserProfile.create(first_name: 'Bill', last_name: 'Lumbergh', job_title: 'Manager', phone: '8001234567', user: client_2_contact_1)
  client_2_contact_2 = Contact.create(name: 'ihatemyjob', email: 'peter.gibbons@corp.com', password: 'password', password_confirmation: 'password', client: client_2)
  UserProfile.create(first_name: 'Petter', last_name: 'Gibbons', job_title: 'Executive', phone: '8001234568', user: client_2_contact_2)
  client_2_contact_3 = Contact.create(name: 'iwasboltonfirst', email: 'michael.bolton@corp.com', password: 'password', password_confirmation: 'password', client: client_2)
  UserProfile.create(first_name: 'Michael', last_name: 'Bolton', job_title: 'Executive', phone: '8001234569', user: client_2_contact_3)
  client_2_contact_4 = Contact.create(name: 'backupinthatass', email: 'samir.nagheenanajar@corp.com', password: 'password', password_confirmation: 'password', client: client_2)
  UserProfile.create(first_name: 'Samir', last_name: 'Nagheenanajar', job_title: 'Executive', phone: '8001234570', user: client_2_contact_4)
  client_3_contact_1 = Contact.create(name: 'istartedpaypal', email: 'elon@start.com', password: 'password', password_confirmation: 'password', client: client_3)
  UserProfile.create(first_name: 'Elon', last_name: 'Musk', job_title: 'Certified Bad Ass', phone: '1112223333', user: client_3_contact_1)
  client_3_contact_2 = Contact.create(name: 'thejobs', email: 'steve@start.com', password: 'password', password_confirmation: 'password', client: client_3)
  UserProfile.create(first_name: 'Steve', last_name: 'Jobs', job_title: 'Money Maker', phone: '2223334444', user: client_3_contact_2)

  Permission.seed
  User.all.each do |user|
    user.permissions << Permission.all
  end
end
