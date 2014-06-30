module Workers
  class SyncDomain
    # Worker which queries the Google Admin SDK Directory API and retrieves a
    # list of current users on the domain. It then creates new users if they do
    # not exist in Trailblazer, and flags users that no longer exist on Google
    # (or are disabled) so that they can be selectively disabled on Trailblazer -
    # a process which requires admin intervention before any change is effected.
    #
    # On first run, i.e. when a domain is first created, this worker can be
    # promoted to the :first_run queue for priority execution.

    # Thin wrapper around job creation so we can set the queue dynamically
    def self.enqueue(domain_name, admin_id, queue = :sync_domain)
      Resque::Job.create(queue, self, domain_name, admin_id)
    end

    def self.perform(domain_name, admin_id)
      admin  = User.find(admin_id)
      domain = Domain.find_by(:domain => domain_name)
      domain.update_attribute(:importing, true)

      client = ApiWrappers::Google.new(admin)
      client.fetch_access_token!

      self.sync_orgunits(client, domain)
      self.sync_users(client, domain)
    end

    # Reads users off the Google Apps domain, creating records for new users
    # and updating the record of existing users.
    def self.sync_users(client, domain)
      params = {
        :maxResults => 500,
        :pageToken  => nil
      }
      begin
        response = client.directory_users_list(domain.domain, params)

        users = JSON.load(response.body).fetch("users", [])

        ActiveRecord::Base.transaction do
          users.each do |u|
            user = User.find_or_initialize_by(:uid => u.fetch("id")) do |r|
              r.active = false
            end

            user.admin          = u.fetch("isAdmin", false)

            user.name           = u.fetch("name", {}).fetch("fullName", nil)
            user.first_name     = u.fetch("name", {}).fetch("givenName", nil)
            user.last_name      = u.fetch("name", {}).fetch("familyName",  nil)

            user.email          = u.fetch("primaryEmail",      nil)
            user.image          = u.fetch("thumbnailPhotoUrl", nil)

            user.org_unit_path  = u.fetch("orgUnitPath", nil)
            if user.org_unit_path.present?
              user.org_unit = OrgUnit.find_by(:domain_id => domain.id, :org_unit_path => user.org_unit_path)
            end

            user.save
          end
        end

        params[:pageToken] = response.next_page_token
      end while params[:pageToken].present?

      nil
    end

    # Reads Organizational Units from the Google apps domain, creating new
    # records when required.
    # There is presently no way of identifying when an org unit name changes,
    # so a new record will be created in that instance.
    # A user may only belong to one org unit.
    def self.sync_orgunits(client, domain)
      response = client.directory_orgunits_list(domain.domain)

      units = JSON.load(response.body).fetch("organizationUnits", [])

      ActiveRecord::Base.transaction do
        units.each do |u|
          orgunit = OrgUnit.find_or_initialize_by(:domain_id => domain.id, :org_unit_path => u.fetch("orgUnitPath"))

          orgunit.parent_org_unit_path = u.fetch("parentOrgUnitPath", nil)
          orgunit.description          = u.fetch("description",       nil)
          orgunit.name                 = u.fetch("name",              nil)

          orgunit.save
        end
      end

      nil
    end
  end
end
