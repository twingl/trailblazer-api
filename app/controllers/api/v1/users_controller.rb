module Api::V1
  class UsersController < ApiController
    before_action :doorkeeper_authorize!

    def me
      render :json => current_resource_owner.to_json(:expand => [:classrooms, :assignments])
    end

    def backup
      backup = current_resource_owner.assignment_backups.build(backup_params)

      if backup.save
        head :no_content
      else
        head :bad_request
      end
    end

  private

    def backup_params
      params.permit(:backup)
    end
  end
end
