class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create

  # Callback endpoint for authenticating using OmniAuth::GoogleOauth2
  # Calls GetOauthUser to retrieve a user, redirecting to +landing_url+ if none
  # was returned.
  def create_google
    if user = GetOauthUser.new(:service_hash => omniauth_hash).call
      establish_session user
      redirect_to return_location
    else
      redirect_to landing_url, :notice => "Error signing in"
    end
  end

  # Signs out the current user and redirects to +landing_url+
  def destroy
    destroy_session
    redirect_to landing_url
  end
end
