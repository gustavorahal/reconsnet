
##
# Interface com o sistema Cloud de mail marketing
# Atualmente é o Mailchimp
#

class EmailMktService

  @list_id = Rails.configuration.reconsnet['mailchimp_list_id']
  @api_key = Rails.configuration.reconsnet['mailchimp_api_key']

  def self.subscribe(email, first_name, last_name)
    gb = self.get_conn


    #gibbon.lists(list_id).members(lower_case_md5_hashed_email_address).upsert(body: {email_address: "foo@bar.com", status: "subscribed", merge_fields: {FNAME: "First Name", LNAME: "Last Name"}})

    gb.lists(@list_id).members(self.lower_case_md5_hashed_email_address(email)).
                                                upsert(body: { email_address: email.downcase,
                                                               status: 'subscribed',
                                                               double_optin: false,
                                                               merge_fields: { FNAME: first_name, LNAME: last_name } })
    refresh_subscribed_list
  end

  def self.unsubscribe(email)
    gb = self.get_conn
    gb.lists(@list_id).members(self.lower_case_md5_hashed_email_address(email)).update(body: { status: 'unsubscribed' })

    refresh_subscribed_list
  end

  def self.delete(email)
    gb = self.get_conn
    gb.lists(@list_id).members(self.lower_case_md5_hashed_email_address(email)).delete

    refresh_subscribed_list
  end

  def self.subscribed?(email)
    subscribed_list.include?(email)
  end

  def self.subscribed_list
    Rails.cache.fetch('email_subscribed_list', expires_in: 1.hour) do
      gb = self.get_conn

      sub_list = []
      # Quando a lista tiver mais de 5.000, rever
      count = 5000
      result = gb.lists(@list_id).members.retrieve(params: { status: 'subscribed', count: count })
      members = result.body['members']
      members.each do |member|
        sub_list.append member['email_address']
      end

      sub_list
    end
  end


  private

    def self.lower_case_md5_hashed_email_address(email)
      Digest::MD5.hexdigest(email.downcase)
    end

    def self.get_conn
      Gibbon::Request.new(api_key: @api_key)
    end

    def self.refresh_subscribed_list
      Rails.cache.delete('email_subscribed_list')
      subscribed_list
    end

end