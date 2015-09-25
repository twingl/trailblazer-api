require 'contexts/user_requests_password_reset'
require 'contexts/user_confirms_account'
require 'contexts/user_reverts_email_confirmation'

class RegistrationsController < ApplicationController
  skip_before_action :authenticate_staging
  before_action :authenticate_user!, :only => [:show, :update, :resend_confirmation]

  # POST /sign_up
  def create
    user = User.new(registration_params)

    if user.save
      establish_session user
      user.send_confirmation
      render :json => { :location => return_location }
    else
      render :status => :unauthorized, :json => { :error => :email_taken, :message => "Looks like that email address is taken. Have you forgotten your password?" }
    end
  end

  # GET /profile
  def show
  end

  # POST /profile
  def update
    user = current_user

    #if password_params[:password].present? || password_params[:current_password].present?
    #  if user.authenticate(password_params[:current_password]) &&
    #    user.update_attributes(registration_params)
    #    render :json => { :user => user }
    #  else
    #    render :status => :bad_request, :json => { :messages => user.errors.full_messages }
    #  end
    #else
      if user.update_attributes(registration_params)
        render :json => { :user => user }
      else
        render :status => :bad_request, :json => { :messages => user.errors.full_messages }
      end
    #end
  end

  # POST /resend_confirmation
  def resend_confirmation
    current_user.send_confirmation
    render :json => { :message => "Confirmation email sent to #{current_user.email}" }
  end

  # User's email is marked as confirmed
  def confirm
    if @user = UserConfirmsAccount.new(:token => params[:token]).call
      self.establish_session @user
      redirect_to profile_url, :notice => "Thanks for confirming #{@user.email}"
    else
      redirect_to profile_url, :notice => "There was a problem confirming - try re-sending the email?"
    end
  end

  # GET /revert/:token
  # Reverts an email change
  def revert
    user = UserRevertsEmailConfirmation.new(:token => params[:token]).call

    if current_user == user
      redirect_to profile_url
    else
      redirect_to profile_url, :notice => "There was a problem reverting the email change - try again?"
    end
  end

  # POST /forgot_password
  # Calls the context and if it returns a user, we send a password reset email
  # to that address
  #
  # Always responds with a 204
  def forgot_password
    user = UserRequestsPasswordReset.new(:email => registration_params[:email]).call
    UserMailer.password_reset_email(user).deliver if user
    head 204
  end

  # Creates a session for the user based on a token that was emailed to them
  # and sends them to their profile page.
  # Token is destroyed on sign in.
  def reset_password
    user = User.find_by(:reset_password_token => params[:token])

    if user
      self.establish_session user
      redirect_to profile_url
    else
      # render a 404
    end
  end

private

  def registration_params
    params.require(:user).permit(:email, :password)
  end

  def password_params
    params.require(:user).permit(:password, :current_password)
  end
end
