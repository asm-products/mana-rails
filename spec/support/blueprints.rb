require 'machinist/active_record'

Client.blueprint do
  name       { 'TestName' }
  address { 'TestAdress' }
  phone { '12345' }
  short_code { sn }
  website { 'http://www.testweb.com' }
	account_manager_id { User.make.id }
end

Issue.blueprint do
  subject { 'Test Subject' }
  project { Project.make! }
end

Project.blueprint do
  name       { "TestName#{sn}" }
  short_code { '1234#{sn}' }
  client_id     { Client.make.id }
end

User.blueprint do
  name       { "TestName#{sn}" }
  email      { "test#{sn}@test.com" }
  password   { 'testtest' }
  teams { [Team.make!] }
  profile { Profile.make! }
end

Profile.blueprint do
  address          { 'TestAddress' }
  secondary_phone  { '(555) 555-5555' }
  time_zone        { 'Pacific' }
  twitter_name     { '@manacore' }
end

Contact.blueprint do
  name       { 'TestContact' }
  email      { 'testcontact@test.com' }
  password   { 'testtest' }
  client {Client.make!}
end

Team.blueprint do
  name       { 'TestName' }
end

Membership.blueprint do
  user { User.make! }
  team { Team.make! }
end

Comment.blueprint do
  subject { 'Test Comment' }
  body { 'Test Body'}
  commenter { User.make!(email: "testcommenter@test.com",
                        name: "testcommenter1") }
end

Permission.blueprint do
  klass { 'User' }
  action { 'manage' }
  description { 'Lorem ipsum' }
end

Role.blueprint do
  name { 'testrole' }
  short_code { sn }
end
