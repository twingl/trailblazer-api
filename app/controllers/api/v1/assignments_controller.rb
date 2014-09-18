module Api::V1
  class AssignmentsController < ApiController
    doorkeeper_for :all
    before_action :set_assignment, :except => [:index, :create]

    def index
      render :json => { :assignments => current_resource_owner.assignments }
    end

    def show #TODO
    end

    def create #TODO
      project = Project.create(project_params)
      @assignment = project.assign_to(current_resource_owner)

      if @assignment.errors.empty?
        render :json => @assignment
      else
        render :json => { :errors => @assignment.errors.full_messages }, :status => 422
      end
    end

    def update #TODO
      if @assignment.update_attributes(assignment_params)
        render :json => @assignment
      else
        render :json => { :errors => @assignment.errors.full_messages }, :status => 422
      end
    end

    def destroy #TODO
    end

  private

    def set_assignment
      @assignment = current_resource_owner.assignments.find(params[:id])
    end

    def assignment_params
      params.require(:assignment).permit(:current_node_id, :title, :description, :started_at, :completed_at)
    end

    def project_params
      params.require(:assignment).permit(:title, :description)
    end
  end
end
