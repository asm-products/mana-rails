class ContactMailer < ActionMailer::Base
  default from: "noreply@mana.com" # TODO: change this email address once an appropriate email address has been setup.
  
  def verify_email(client, contact)
    @client = client
    @contact = contact
    @url = client_contact_verify_path(@client.short_code, @contact.special_key).to_s
  end
end
