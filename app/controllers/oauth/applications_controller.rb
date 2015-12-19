class Oauth::ApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_application, :only => [:show, :edit, :update, :destroy]

  layout 'session'

  def index
    @applications = current_user.oauth_applications
  end

  def show
  end

  def new
    @application = current_user.oauth_applications.build
  end

  def create
    @application = current_user.oauth_applications.build
    if @application.update_attributes(application_params)
      redirect_to oauth_application_path(@application)
    else
      render :new
    end
  end

  def update
    if @application.update_attributes(application_params)
      redirect_to oauth_application_path(@application)
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @application.destroy
    redirect_to oauth_applications_path
  end

private

  def set_application
    @application = current_user.oauth_applications.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def application_params
    params.require(:doorkeeper_application).permit(:name, :redirect_uri, :description)
  end
end
