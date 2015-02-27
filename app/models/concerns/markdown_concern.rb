module MarkdownConcern
  extend ActiveSupport::Concern

  def capture_mention(source)
    output = HTML::Pipeline::MentionFilter.mentioned_logins_in(source) do |mention|
      pre = mention[0] == "@" ? "" : mention.slice!(0)
      mention_user = User.find_for_mention(mention)
      mention_client = Client.find_for_mention(mention)


      if mention_user
        if !mention_user.client_id.nil?
            client = Client.find(mention_user.client_id)
            "<a href=\"/clients/#{client.short_code}/contacts/#{mention_user.name}\">#{mention}</a>"  # return contacts url for contacts
        else
            pre + "<a href=\"/users/#{mention_user.name}\">#{mention}</a>" # return user url for users
        end
      else
        if mention_client
          pre + "<a href=\"/clients/#{mention_client.short_code}\">#{mention}</a>" #return clients url
        else
          pre + mention
        end
      end
    end
  end
end