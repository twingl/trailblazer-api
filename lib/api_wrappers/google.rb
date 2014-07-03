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

    # Fetch a list of users registered to the domain
    # https://developers.google.com/admin-sdk/directory/v1/reference/users/list
    def directory_users_list(params = {})
      parameters = { :customer => "my_customer" }.merge(params)

      # Discover the Admin SDK Directory API
      directory = client.discovered_api('admin', 'directory_v1')

      # Fetch a list of the users in this domain
      response = client.execute(:api_method => directory.users.list, :parameters => parameters)
    end

    # Fetch a list of OrgUnits from the domain
    # https://developers.google.com/admin-sdk/directory/v1/reference/orgunits/list
    def directory_orgunits_list(domain_name, params = {})
      parameters = { :customerId => "my_customer" }.merge(params)

      # Discover the Admin SDK Directory API
      directory = client.discovered_api('admin', 'directory_v1')

      # Fetch a list of the org units in this domain
      response = client.execute(:api_method => directory.orgunits.list, :parameters => parameters)
    end

    # Fetch a list of Groups from the domain
    # https://developers.google.com/admin-sdk/directory/v1/reference/groups/list
    def directory_groups_list(params = {})
      parameters = { :customer => "my_customer" }.merge(params)

      # Discover the Admin SDK Directory API
      directory = client.discovered_api('admin', 'directory_v1')

      # Fetch a list of the groups in this domain
      response = client.execute(:api_method => directory.groups.list, :parameters => parameters)
    end

    # Fetch the members of a group specified by group_key
    # This is the unique id of the group `groupKey`
    # https://developers.google.com/admin-sdk/directory/v1/reference/members/list
    def directory_groups_members(group_key, params = {})
      parameters = { :groupKey => group_key }.merge(params)

      # Discover the Admin SDK Directory API
      directory = client.discovered_api('admin', 'directory_v1')

      # Fetch a list of the groups' members
      response = client.execute(:api_method => directory.members.list, :parameters => parameters)
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
          'https://www.googleapis.com/auth/admin.directory.orgunit.readonly',
          'https://www.googleapis.com/auth/admin.directory.group.readonly'
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
