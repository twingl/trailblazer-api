require 'playhouse/context'

class UserConfirmsAccount < Playhouse::Context

  actor :token

  def perform
    user = User.find_by(:confirmation_token => token)

    if user
      user.update_attributes :confirmed_at => DateTime.now.utc,
                             :confirmation_token => nil,
                             :last_confirmed_at => nil,
                             :last_email => nil
      user
    else
      false
    end
  end
end
