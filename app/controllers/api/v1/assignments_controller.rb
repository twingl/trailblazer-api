module Api::V1
  class AssignmentsController < ApiController
    doorkeeper_for :all

    def index
      render :json => { :assignments => current_resource_owner.assignments }
    end

    def show #TODO
    end

    def create #TODO
    end

    def update #TODO
    end

    def destroy #TODO
    end
  end
end
