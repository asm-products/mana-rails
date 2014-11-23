require 'machinist/active_record'

Client.blueprint do
  name       { "TestName" }
  short_code { "12345" }
end
