class UnsubscribeEmailJob < ApplicationJob
  queue_as :default

  def perform(email)
    EmailMktService.unsubscribe(email)
  end
end