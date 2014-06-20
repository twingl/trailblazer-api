require 'contexts/get_oauth_user'

class PagesController < ApplicationController

  # Endpoint for configuring a domain. Expects ?domain=example.com to be set.
  def configure
    if user_signed_in?
      #TODO Extract logic in this block out into its own sane set of modules/contexts/roles
      key = OpenSSL::PKey::RSA.new ENV['GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY'], ENV['GOOGLE_SERVICE_ACCOUNT_SECRET']
      client = Google::APIClient.new :application_name    => ENV['GOOGLE_APPLICATION_NAME'],
                                    :application_version => ENV['GOOGLE_APPLICATION_VERSION'],
                                    :authorization       => Signet::OAuth2::Client.new(
                                      :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
                                      :audience             => 'https://accounts.google.com/o/oauth2/token',
                                      :scope                => 'https://www.googleapis.com/auth/admin.directory.user.readonly',
                                      :issuer               => ENV['GOOGLE_SERVICE_ACCOUNT_EMAIL'],
                                      :signing_key          => key,
                                      :sub                  => current_user.email)
      client.authorization.fetch_access_token!
      directory = client.discovered_api('admin', 'directory_v1')
      # client.execute(:api_method => directory.users.list, :parameters => { :domain => params[:domain] }).response.body
      # authenticate_admin!
      render :json => client.execute(:api_method => directory.users.list, :parameters => { :domain => params[:domain] }).response.body
    else
      store_location(request.url)
      redirect_to '/auth/google_apps'
    end
  end

  def landing
  end

  # Page shown to signed in users who are not marked as +active+
  def inactive
  end
end
