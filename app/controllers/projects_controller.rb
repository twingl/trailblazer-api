class ProjectsController < ApplicationController
  before_action :set_classroom, only: [:index, :new, :create]
  before_action :set_project, only: [:show, :edit, :update, :assign, :destroy]

  # GET /projects
  def index
    @projects = @classroom.projects

    respond_to do |format|
      format.html
      format.json { render :json => { :projects => @projects } }
    end
  end

  # GET /projects/1
  def show
    respond_to do |format|
      format.html
      format.json { render :json => @project }
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = @classroom.projects.build(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :json => @project }
      else
        format.html { render :new }
        format.json { render :json => { :errors => @project.errors.full_messages }, :status => 422 }
      end
    end
  end

  # PATCH/PUT /projects/1
  def update
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully updates.' }
        format.json { render :json => @project }
      else
        format.html { render :edit }
        format.json { render :json => { :errors => @project.errors.full_messages }, :status => 422 }
      end
    end
  end

  # PATCH/PUT /projects/1/assign
  def assign
    users = current_user.domain.users.where(:id => assignment_params.fetch(:users, []))

    @project.assignments = @project.assignments.to_a.concat(users.to_a)
    @project.reload

    render :json => { :assignments => @project.assignments }, :status => 200
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects, notice: 'Project was successfully destroyed.' }
      format.json { head 200 }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = @classroom.projects.find(params[:id])
    end

    def set_classroom
      @classroom = current_user.classrooms.find(params[:classroom_id])
    end

    def assignment_params
      params.permit(:users => [])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.permit(:name, :description, :classroom_id, :due_at, :visible)
    end
end
