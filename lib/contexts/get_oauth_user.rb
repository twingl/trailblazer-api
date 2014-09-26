require 'playhouse/context'

# Responsible for finding or creating a user which represents the supplied
# identity.
#
# The +:service_hash+ actor is assumed to be a response from OmniAuth's Google
# OAuth2 strategy.
class GetOauthUser < Playhouse::Context
  actor :service_hash

  def perform
    User.find_or_create_by(:uid => service_hash["uid"]) do |u|
      u.active = false
      u.admin  = false

      u.name           = service_hash.fetch("info", {}).fetch("name",       nil)
      u.email          = service_hash.fetch("info", {}).fetch("email",      "").downcase
      u.first_name     = service_hash.fetch("info", {}).fetch("first_name", nil)
      u.last_name      = service_hash.fetch("info", {}).fetch("last_name",  nil)
      u.image          = service_hash.fetch("info", {}).fetch("image",      nil)
      u.google_profile = service_hash.fetch("info", {}).fetch("urls", {}).fetch("Google", nil)

      u.confirmed_at   = DateTime.now

      u.gender = service_hash.fetch("extra", {}).fetch("raw_info", {}).fetch("sex", nil)
    end
  end
end
