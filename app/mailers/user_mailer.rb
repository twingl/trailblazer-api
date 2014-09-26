class UserMailer < ActionMailer::Base
  include SendGrid
  sendgrid_category :use_subject_lines
  sendgrid_enable :ganalytics
  sendgrid_ganalytics_options :utm_source => "account_management"

  default from: "accounts@trailblazer.io", reply_to: "hello@trailblazer.io"

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
