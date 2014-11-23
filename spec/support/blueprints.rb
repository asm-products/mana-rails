require 'machinist/active_record'

Client.blueprint do
  name       { "TestName" }
  short_code { "12345" }
end

Issue.blueprint do
  subject { "Test Subject" }
end

Project.blueprint do
  name       { "TestName" }
  short_code { "1234" }
  client_id     { Client.make.id }
end

User.blueprint do
  name       { "TestName" }
  email      { "test@test.com" }
  password   { "testtest" }
end
