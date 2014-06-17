class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create

  def create
    render :json => omniauth_hash.to_json
  end
end
