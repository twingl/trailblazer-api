require 'playhouse/context'

class UserRequestsPasswordReset < Playhouse::Context

  actor :email

  def perform
    user = User.find_by(:email => email)

    if user
      token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless User.exists?(:reset_password_token => random_token)
      end

      user.update_attributes({
        :reset_password_token => token,
        :reset_password_sent_at => DateTime.now.utc
      })
      user
    else
      false
    end
  end
end
