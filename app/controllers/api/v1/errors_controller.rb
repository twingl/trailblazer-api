module Api::V1
  class ErrorsController < ApiController
    include Gaffe::Errors

    layout false

    def show
      output = { error: @rescue_response }
      output.merge! exception: @exception.inspect, backtrace: @exception.backtrace.first(10) if Rails.env.development? || Rails.env.test?
      render json: output, status: @status_code
    end
  end
end
