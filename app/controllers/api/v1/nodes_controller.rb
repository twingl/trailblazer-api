module Api::V1
  class NodesController < ApiController
    doorkeeper_for :all

    before_action :set_assignment, :only => [:index, :create]
    before_action :set_assignment

    def index
      render :json => { :nodes => @assignment.nodes }
    end

    def show #TODO
      render :json => { :nodes => @node }
    end

    def create #TODO ? - scope of the API
      @node = @assignment.nodes.build(node_params)

      if @node.save
        render :json => @node
      else
        render :json => { :errors => @node.errors.full_messages }, :status => 422
      end
    end

    def update #TODO ? - scope of the API
      if @node.update_attributes(node_params)
        render :json => @node
      else
        render :json => { :errors => @node.errors.full_messages }, :status => 422
      end
    end

    def destroy #TODO ? - scope of the API
      @node.destroy
      head 200
    end

  private
    
    def set_assignment
      @assignment = current_resource_owner.assignments.find(params[:assignment_id])
    end

    def set_node
      @node = current_resource_owner.nodes.find(node_params)
    end

    def node_params
      params.require(:node).permit(:url, :title, :arrived_at, :departed_at, :idle, :parent_id)
    end
  end
end
