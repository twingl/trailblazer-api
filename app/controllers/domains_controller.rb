require 'contexts/get_oauth_user'
require 'contexts/get_google_apps_domain'

class DomainsController < ApplicationController
  skip_before_action :authenticate_valid_account!, :only => [:configure]

  # Endpoint for configuring a domain.
  #
  # GET /domains/example.com/configure
  def configure
    if user_signed_in?
      @domain = GetGoogleAppsDomain.new(:user => current_user, :domain_name => params[:domain_name]).call

      render 'configure.importing' if @domain.importing?
    else
      store_location(request.url)
      redirect_to '/auth/google_apps'
    end
  end
end

