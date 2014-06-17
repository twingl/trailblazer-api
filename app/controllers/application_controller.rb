class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def establish_session(user)
    @current_user = user
    session[:user_id] = user.nil? ? user : user.id
  end

  def destroy_session
    @current_user = nil
    session.clear
  end

  def user_signed_in?
    !!current_user
  end

  def authenticate_user!(location = request.url)
    unless user_signed_in?
      flash[:error] = 'Please sign in before viewing this page.'
      redirect_to sign_in_path
    end
  end

  def omniauth_hash
    request.env["omniauth.auth"]
  end
end
