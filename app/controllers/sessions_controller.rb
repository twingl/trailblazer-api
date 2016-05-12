require 'contexts/get_sign_in_method'
require 'contexts/get_oauth_user'
require 'contexts/user_signs_in'

class SessionsController < ApplicationController

  before_action :authenticate_user!, :except => [:sign_in_method, :new, :create, :create_google]

  # GET /sign_in_method
  # Checks an email address, returning the sign in route to be taken.
  # Options to return are: sign_up, password, oauth
  def sign_in_method
    @method = GetSignInMethod.new(email: params[:email]).call
    render json: { method: @method, message: I18n.t(@method, scope: [:session, :sign_in_method]) }
  end

  # Callback endpoint for authenticating using OmniAuth::GoogleOauth2
  # Calls GetOauthUser to retrieve a user, redirecting to +sign_in_url+ if none
  # was returned.
  #
  # GET/POST /auth/google_apps/callback
  # GET/POST /auth/google_apps_chooser/callback
  def create_google
    @user = GetOauthUser.new(:service_hash => omniauth_hash).call

    if @user
      establish_session @user
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
      redirect_to return_location
    else
      @user = User.new session_params
      flash.now[:sign_in] = "We couldn't sign you in. If you're new here, click 'Create Account' to get started"
      render 'sessions/new', status: :unauthorized
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
