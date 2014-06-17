Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_OAUTH2_CLIENT_ID"], ENV["GOOGLE_OAUTH2_CLIENT_SECRET"], { access_type: "online", approval_prompt: "none", include_granted_scopes: "true" }
end
