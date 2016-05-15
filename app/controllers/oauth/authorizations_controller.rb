class Oauth::AuthorizationsController < ::Doorkeeper::AuthorizationsController
  helper_method :current_user
  helper_method :user_signed_in?

  before_action :hide_nav!

  def new
    if pre_auth.authorizable?
      if skip_authorization?
        auth = authorization.authorize
        redirect_to auth.redirect_uri
      else
        render 'doorkeeper/authorizations/new', :layout => "application"
      end
    else
      render 'doorkeeper/authorizations/error', :layout => "application"
    end
  end

protected

  # Hide the application nav bar
  def hide_nav!
    @hide_nav = true
  end

  # Returns the currently authenticated user
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  # Returns whether there is a valid session.
  def user_signed_in?
    !!current_user
  end
end
