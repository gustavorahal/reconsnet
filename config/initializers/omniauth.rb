Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity,
           :on_failed_registration => lambda { |env|
             IdentitiesController.action(:new).call(env)
           }

  OmniAuth.config.on_failure = Proc.new { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }

end