class Public::MapsController < ApplicationController
  before_action :set_map

  def show
    render :layout => "public-map"
  end

private

  def set_map
    @assignment = Assignment.find_by!(:visible => true, :public_url_token => map_params[:token])

    @nodes = @assignment.nodes.includes(:context) || []
  end

  def map_params
    params.permit(:token)
  end
end
