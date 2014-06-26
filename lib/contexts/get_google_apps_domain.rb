require 'playhouse/context'

# Constructs a client for the Google Apps privileged APIs
# The +:user+ actor is tested to be a Google Apps admin of the domain
class GetGoogleAppsDomain < Playhouse::Context
  actor :user
  actor :domain_name

  def perform
    # Initialize the Google API client
    client = api_client(user)

    # Discover the Admin SDK Directory API
    directory = client.discovered_api('admin', 'directory_v1')

    # Fetch a list of the users in this domain
    response = client.execute(:api_method => directory.users.list, :parameters => { :domain => domain_name })

    if response.success?
      domain = Domain.find_or_create_by(:domain => domain_name)

      user.domain_admin_roles.find_or_create_by(:domain => domain)

      # Creation of a domain spins up a worker which imports all of the people,
      # setting a flag on the domain once it is imported.

      domain
    else
      false
    end
  end

  def api_client(user)
    signing_key = OpenSSL::PKey::RSA.new(ENV['GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY'],
                                         ENV['GOOGLE_SERVICE_ACCOUNT_SECRET'])

    authorization = Signet::OAuth2::Client.new(
      :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
      :audience             => 'https://accounts.google.com/o/oauth2/token',
      :scope                => 'https://www.googleapis.com/auth/admin.directory.user.readonly',
      :issuer               => ENV['GOOGLE_SERVICE_ACCOUNT_EMAIL'],
      :signing_key          => signing_key,
      :sub                  => user.email)

    client = Google::APIClient.new(
      :application_name     => ENV['GOOGLE_APPLICATION_NAME'],
      :application_version  => ENV['GOOGLE_APPLICATION_VERSION'],
      :authorization        => authorization)

    client.authorization.fetch_access_token!
    client
  end
end
