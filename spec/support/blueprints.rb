require 'machinist/active_record'

Client.blueprint do
  name       { 'TestName' }
  short_code { '12345' }
end

Issue.blueprint do
  subject { 'Test Subject' }
  project { Project.make! }
end

Project.blueprint do
  name       { 'TestName' }
  short_code { '1234' }
  client_id     { Client.make.id }
end

User.blueprint do
  name       { 'TestName' }
  email      { 'test@test.com' }
  password   { 'testtest' }
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

Comment.blueprint do
  subject { 'Test Comment' }
  body { 'Test Body'}
  commenter { User.make!(email: "testcommenter@test.com",
                        name: "testcommenter1") }
end

