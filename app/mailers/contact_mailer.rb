class ContactMailer < ActionMailer::Base
  default from: "noreply@getmana.io"
  
  def verify_email(client, contact)
    @client = client
    @contact = contact
    @url = client_contact_verify_path(@client.short_code, @contact.special_key).to_s
  end
end
