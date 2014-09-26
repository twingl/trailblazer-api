class TrailblazerAdmin::ApplicationController < ApplicationController
  before_action :authenticate_trailblazer_admin!

  helper_method :trailblazer_admin_signed_in?,
                :authenticate_trailblazer_admin!,

private

  # Returns whether there is a trailblazer admin signed in
  def trailblazer_admin_signed_in?
    user_signed_in? and TrailblazerAdmin.exists?(:user_id => current_user.id)
  end

  # Check if there is a valid admin session and prompt to reauth if not
  def authenticate_trailblazer_admin!(location = request.url)
    unless trailblazer_admin_signed_in?
      store_location(location)
      destroy_session
      redirect_to sign_in_url
    end
  end

end
