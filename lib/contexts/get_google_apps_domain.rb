require 'playhouse/context'

# Constructs a client for the Google Apps privileged APIs
# The +:user+ actor is tested to be a Google Apps admin of the domain
class GetGoogleAppsDomain < Playhouse::Context
  actor :user
  actor :domain_name

  def perform
    # Initialize the Google API client
    client = ApiWrappers::Google.new(user)
    client.fetch_access_token!

    # Fetch a list of the users in this domain
    response = client.directory_users_list(domain_name)

    if response.success?
      domain = Domain.find_or_create_by(:domain => domain_name)

      user.domain_admin_roles.find_or_create_by(:domain => domain)

      Workers::SyncDomain.enqueue(domain_name, user.id, :first_run) unless domain.imported?

      domain
    else
      false
    end
  end
end
