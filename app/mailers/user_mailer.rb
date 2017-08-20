class UserMailer < ActionMailer::Base
  include SendGrid
  sendgrid_category :use_subject_lines
  sendgrid_enable :ganalytics
  sendgrid_ganalytics_options :utm_source => "account_management"

  default from: "accounts@#{ENV.fetch("APP_HOSTNAME")}", reply_to: "hello@#{ENV.fetch("APP_HOSTNAME")}"

  def confirm_email(user)
    @user  = user
    @token = user.confirmation_token
    mail :to => @user.email, :subject => "Please confirm your email address"
  end

  def password_reset_email(user)
    @user  = user
    @token = user.reset_password_token
    mail :to => @user.email, :subject => "Reset your Trailblazer password"
  end
end
