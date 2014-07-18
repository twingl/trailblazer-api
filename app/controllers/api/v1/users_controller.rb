module Api::V1
  class UsersController < ApiController
    doorkeeper_for :all

    def me
      render :json => current_resource_owner.to_json(:expand => [:classrooms, :assignments])
    end
  end
end
