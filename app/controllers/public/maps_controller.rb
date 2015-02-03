class Public::MapsController < ApplicationController
  before_action :set_map

  def show
  end

private

  def set_map
    @assignment = Assignment.where(:visible => true)
                     .find_by(:public_url_token => map_params[:token])

    @nodes = @assignment.nodes.includes(:context) || []
    raise ActiveRecord::RecordNotFound unless @assignment
  end

  def map_params
    params.permit(:token)
  end
end
