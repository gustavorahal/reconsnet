
##
# Interface com o sistema Cloud de mail marketing
# Atualmente é o Mailchimp
#

class EmailMktService

  @list_id = 'a11c726e0c'

  def self.subscribe(name, email)
    gb = self.get_conn
    gb.lists.subscribe({:id => @list_id, :email => {:email => email},
                        :merge_vars => { :NAME => name },
                        :double_optin => false})

    refresh_subscribed_list
  end

  def self.unsubscribe(email)
    gb = self.get_conn
    gb.lists.unsubscribe(:id => @list_id, :email => {:email => email},
                         :delete_member => true)

    refresh_subscribed_list
  end


  def self.subscribed?(email)
    subscribed_list.include?(email)
  end

  def self.subscribed_list
    Rails.cache.fetch('email_subscribed_list', expires_in: 1.hour) {
      sub_list = []
      gb = self.get_conn
      result = gb.lists.members({id: @list_id})
      result['data'].each do |user|
        sub_list.append user['email']
      end
      sub_list
    }
  end


  private

    def self.get_conn
      Gibbon::API.new(Rails.application.secrets.mailchimp_api_key)
    end

    def self.refresh_subscribed_list
      Rails.cache.delete('email_subscribed_list')
      subscribed_list
    end

end