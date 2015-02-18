module Api::V1
  class NodesController < ApiController
    doorkeeper_for :all

    before_action :set_assignment, :only => [:index, :create, :update_coords]
    before_action :set_node, :except => [:index, :create, :update_coords]

    def index
      render :json => { :nodes => @assignment.nodes }
    end

    def show
      render :json => { :nodes => @node }
    end

    def create
      @node = @assignment.nodes.build(node_params.merge(:user => current_resource_owner))

      if @node.save
        render :json => @node
      else
        render :json => { :errors => @node.errors.full_messages }, :status => 422
      end
    end

    def update
      if @node.update_attributes(node_params)
        render :json => @node
      else
        render :json => { :errors => @node.errors.full_messages }, :status => 422
      end
    end

    def update_coords
      Resque.enqueue(Workers::UpdateCoords, current_resource_owner.id, @assignment.id, coord_params)
      head 204
    end

    def destroy
      @node.destroy
      head 204
    end

  private

    def set_assignment
      if params[:assignment_id].present?
        @assignment = current_resource_owner.assignments.find(params[:assignment_id])
      end
    end

    def set_node
      @node = current_resource_owner.nodes.find(params[:id])
    end

    def node_params
      params.require(:node).permit(:url, :title, :arrived_at, :departed_at, :idle, :parent_id, :rank, :temp_id, :redirect, :redirected_from)
    end

    def coord_params
      params.require(:nodes).permit! # FIXME NOPE NOPE NOPE NOOOOOOOOOOPPPPPPPEEEEEEE
    end
  end
end
