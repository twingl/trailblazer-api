module Api::V1
  class ApiController < ActionController::Base
    before_action :authorize_valid_account!

    private

    def current_resource_owner
      @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def authorize_valid_account!
      unless current_resource_owner.domain_id.present?
        head 401
      end
    end
  end
end

