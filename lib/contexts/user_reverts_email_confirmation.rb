require 'playhouse/context'

class UserRevertsEmailConfirmation < Playhouse::Context

  actor :token

  def perform
    if user = User.find_by(:confirmation_token => token)
      if user.last_email.present?
        last_email        = user.last_email
        last_confirmed_at = user.last_confirmed_at
        # We want to skip AR callbacks here as they clobber confirmed_at
        user.update_columns(
          :email              => last_email,
          :confirmed_at       => last_confirmed_at,
          :confirmation_token => nil,
          :last_confirmed_at  => nil,
          :last_email         => nil
        )
        user
      else
        user.destroy!
        false
      end
    end
  end
end
