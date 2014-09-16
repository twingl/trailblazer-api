class AuthorizationsController < ::Doorkeeper::AuthorizationsController
  helper_method :current_user

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

  # Returns the currently authenticated user
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
end
