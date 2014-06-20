module OmniAuth::Strategies
  class GoogleApps < GoogleOauth2
    def name; :google_apps; end
  end

  class GoogleAppsAdmin < GoogleOauth2
    def name; :google_apps_admin; end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_apps, ENV["GOOGLE_OAUTH2_CLIENT_ID"], ENV["GOOGLE_OAUTH2_CLIENT_SECRET"], {
    access_type:            "online",
    include_granted_scopes: "true"
  }

  provider :google_apps_admin, ENV["GOOGLE_OAUTH2_CLIENT_ID"], ENV["GOOGLE_OAUTH2_CLIENT_SECRET"], {
    access_type:            "online",
    include_granted_scopes: "true"
  }
end
