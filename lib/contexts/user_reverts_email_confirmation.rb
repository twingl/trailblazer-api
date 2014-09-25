require 'playhouse/context'

class UserRevertsEmailConfirmation < Playhouse::Context

  actor :token

  def perform
    if user = User.find_by(:confirmation_token => token)
      if user.last_email.present?
        last_email        = user.last_email
        last_confirmed_at = user.last_confirmed_at
        user.update_attributes(
          :email              => last_email.downcase,
          :confirmed_at       => last_confirmed_at,
          :confirmation_token => nil,
          :last_confirmed_at  => nil,
          :last_email         => nil
        )
      else
        user.destroy!
      end
    end
  end
end
