module ApiWrappers
  class Google

    attr_accessor :impersonated_user
    attr_accessor :client

    def initialize(impersonated_user)
      self.impersonated_user = impersonated_user
      initialize_api_client!
    end

    # Convenience method - cuts down method chaining in business logic
    def fetch_access_token!
      self.client.authorization.fetch_access_token!
    end

    # Convenience proxy method for Admin SDK Domain API.
    # Assembles the directory.users.list call and returns the response to the caller.
    def directory_users_list(domain_name, params = {})
      parameters = { :domain => domain_name }.merge(params)

      # Discover the Admin SDK Directory API
      directory = client.discovered_api('admin', 'directory_v1')

      # Fetch a list of the users in this domain
      response = client.execute(:api_method => directory.users.list, :parameters => parameters)
    end

    # Convenience proxy method for Admin SDK Domain API.
    # Assembles the directory.orgunits.list call and returns the response to the caller.
    def directory_orgunits_list(domain_name, params = {})
      parameters = { :customerId => "my_customer" }.merge(params)

      # Discover the Admin SDK Directory API
      directory = client.discovered_api('admin', 'directory_v1')

      # Fetch a list of the users in this domain
      response = client.execute(:api_method => directory.orgunits.list, :parameters => parameters)
    end

  private

    # Initializes the Google API client
    def initialize_api_client!
      signing_key = OpenSSL::PKey::RSA.new(ENV['GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY'],
                                          ENV['GOOGLE_SERVICE_ACCOUNT_SECRET'])

      authorization = Signet::OAuth2::Client.new(
        :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
        :audience             => 'https://accounts.google.com/o/oauth2/token',
        :scope                => [
          'https://www.googleapis.com/auth/admin.directory.user.readonly',
          'https://www.googleapis.com/auth/admin.directory.orgunit.readonly'
        ],
        :issuer               => ENV['GOOGLE_SERVICE_ACCOUNT_EMAIL'],
        :signing_key          => signing_key,
        :sub                  => impersonated_user.email)

      client = ::Google::APIClient.new(
        :application_name     => ENV['GOOGLE_APPLICATION_NAME'],
        :application_version  => ENV['GOOGLE_APPLICATION_VERSION'],
        :authorization        => authorization)

      self.client = client
    end
  end
end
