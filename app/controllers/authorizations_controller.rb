class AuthorizationsController < ::Doorkeeper::AuthorizationsController
  def new
    if pre_auth.authorizable?
      if skip_authorization?
        auth = authorization.authorize
        redirect_to auth.redirect_uri
      else
        render 'doorkeeper/authorizations/new'
      end
    else
      render 'doorkeeper/authorizations/error'
    end
  end
end
