require 'playhouse/context'

# Responsible for determining the best sign_in method for a user.
#
# Returns any of:
# 
#   - oauth
#   - password
#   - sign_up
#
# in that order of preference (oauth being the most preferred option).
class GetSignInMethod < Playhouse::Context
  actor :email

  def perform
    user = User.find_by(:email => email)

    if user and user.uid.present?
      return "oauth"
    elsif user
      return "password"
    else
      return "sign_up"
    end
  end
end
