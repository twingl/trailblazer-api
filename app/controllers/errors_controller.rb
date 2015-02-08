class ErrorsController < ApplicationController
  include Gaffe::Errors

  layout 'error'

  def show
    render "errors/#{@rescue_response}", status: @status_code
  end
end
