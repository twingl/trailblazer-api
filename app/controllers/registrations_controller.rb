require 'contexts/user_requests_password_reset'

class RegistrationsController < ApplicationController
  skip_before_action :authenticate_staging

  def create
    user = User.new(registration_params)

    if user.save
      render :json => { :location => return_location }
    else
      render :status => :unauthorized, :json => { :error => :email_taken, :message => "Looks like that email address is taken. Have you forgotten your password?" }
    end
  end

  # POST /forgot_password
  # Calls the context and if it returns a user, we send a password reset email
  # to that address
  #
  # Always responds with a 204
  def forgot_password
    user = UserRequestsPasswordReset.new(:email => registration_params[:email])
    #UserMailer.password_reset_email(user).deliver if user
    head 204
  end

private

  def registration_params
    params.require(:user).permit(:email, :password, :new_password)
  end
end
