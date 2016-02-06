class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user,
                :user_signed_in?,
                :admin_signed_in?,
                :authenticate_user!,
                :authenticate_active_user!,
                :establish_session,
                :destroy_session

protected

  # Returns the currently authenticated user
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  # Establishes a session for the specified user.
  def establish_session(user)
    @current_user = user
    session[:user_id] = user.nil? ? user : user.id
  end

  # Destroy the current session.
  def destroy_session
    return_to = session["user_return_to"]
    @current_user = nil
    session.clear
    session["user_return_to"] = return_to
  end

  # Returns whether there is a valid session.
  def user_signed_in?
    !!current_user
  end

  # Returns whether there is a valid session and that user is an admin.
  def admin_signed_in?
    user_signed_in? and current_user.admin?
  end

  # Check if there is a valid session and redirect to +sign_in_url+ if not.
  def authenticate_user!(location = request.url)
    unless user_signed_in?
      store_location(location)
      redirect_to sign_in_url
    end
  end

  # Check if there is a valid session, the user is active, and redirect to
  # +inactive_url+ if not.
  def authenticate_active_user!(location = request.url)
    if user_signed_in?
      redirect_to inactive_url unless current_user.active?
    else
      authenticate_user!(location)
    end
  end

  # Convenience method for accessing a response obtained through OmniAuth.
  def omniauth_hash
    request.env["omniauth.auth"]
  end

  # Stores the location to return to before a redirect is followed.
  # Stored location may be overridden.
  def store_location(path, override = false)
    if override or session["user_return_to"].blank?
      session["user_return_to"] = path
    end
  end

  # Returns the location that was stored by +store_location+ and clears it from
  # the session.
  def return_location
    return_url = session["user_return_to"] || profile_url
    session.delete("user_return_to")
    return_url
  end
end
