class SubscribeEmailJob < ApplicationJob
  queue_as :default

  def perform(email, first_name, last_name)
    EmailMktService.subscribe(email, first_name, last_name)
  end
end