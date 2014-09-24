require 'contexts/get_oauth_user'

class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create
  skip_before_action :authenticate_staging

  before_action :authenticate_user!, :except => [:create_google]

  # Callback endpoint for authenticating using OmniAuth::GoogleOauth2
  # Calls GetOauthUser to retrieve a user, redirecting to +landing_url+ if none
  # was returned.
  #
  # GET/POST /auth/google_apps/callback
  # GET/POST /auth/google_apps_chooser/callback
  def create_google
    if user = GetOauthUser.new(:service_hash => omniauth_hash).call
      establish_session user
      redirect_to return_location
    else
      redirect_to landing_url, :notice => "Error signing in"
    end
  end

  # Signs out the current user and redirects to +landing_url+
  #
  # GET/DELETE /sign_out
  def destroy
    destroy_session
    redirect_to landing_url
  end

  # Sign out and redirect to the sign in path
  # GET/DELETE /change_user
  def change_user
    store_location(params[:return_to]) if params[:return_to]
    destroy_session
    redirect_to "/auth/google_apps_chooser"
  end
end
