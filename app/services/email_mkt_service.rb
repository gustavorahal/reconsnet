
##
# Interface com o sistema Cloud de mail marketing
# Atualmente é o Mailchimp
#

class EmailMktService

  @list_id = 'a11c726e0c'

  def self.subscribe(person)
    gb = self.get_conn
    gb.lists.subscribe({:id => @list_id, :email => {:email => person.email.downcase},
                        :merge_vars => { :FNAME => person.first_name, :LNAME => person.last_name },
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
      gb = self.get_conn

      sub_list = []
      start = 0
      while start < 100 # colocando algum parâmetro de saida/segurança. Quando a lista tiver mais de 10.000, rever
        result = gb.lists.members({ id: @list_id, status: 'subscribed', opts: {start: start, limit: 100} })
        break if result['data'].empty?
        result['data'].each do |user|
          sub_list.append user['email']
        end
        start += 1
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