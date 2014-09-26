require 'contexts/get_oauth_user'
require 'contexts/user_signs_in'

class SessionsController < ApplicationController
  skip_before_action :authenticate_staging

  before_action :authenticate_user!, :except => [:new, :create, :create_google]

  # Callback endpoint for authenticating using OmniAuth::GoogleOauth2
  # Calls GetOauthUser to retrieve a user, redirecting to +sign_in_url+ if none
  # was returned.
  #
  # GET/POST /auth/google_apps/callback
  # GET/POST /auth/google_apps_chooser/callback
  def create_google
    if user = GetOauthUser.new(:service_hash => omniauth_hash).call
      establish_session user
      redirect_to return_location
    else
      redirect_to sign_in_url, :notice => "Error signing in"
    end
  end

  # GET /sign_in
  def new
    @user = User.new
  end

  # POST /sign_in
  def create
    @user = UserSignsIn.new({
      :email    => session_params[:email],
      :password => session_params[:password],
      :ip       => request.remote_ip
    }).call

    if @user.is_a? User
      establish_session @user
      render :json => { :location => return_location }
    elsif @user == :unknown_account
      render :status => :unauthorized, :json => { :error => :unknown_account, :message => "We can't seem to find that email address. If you're new here, click 'Create Account' to get started with these details" }
    else
      render :status => :unauthorized, :json => { :error => :incorrect_details, :message => "Those sign in details don't seem to be right. If you've forgotten your password, hit the button and we'll send you an email." }
    end
  end

  # Signs out the current user and redirects to +sign_in_url+
  #
  # GET/DELETE /sign_out
  def destroy
    destroy_session
    redirect_to sign_in_url
  end

  # Sign out and redirect to the sign in path
  # GET/DELETE /change_user
  def change_user
    store_location(params[:return_to]) if params[:return_to]
    destroy_session
    redirect_to "/sign_in"
  end

private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
