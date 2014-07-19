class AssignmentsController < ApplicationController
  before_action :set_project, except: [:user_index]
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  # GET /assignments
  def index
    @assignments = @project.assignments

    respond_to do |format|
      #format.html
      format.json { render :json => { :assignments => @assignments } }
    end
  end

  # GET /users/:id/assignments
  # FIXME does not currently conform to the data visibility structure - a
  # teacher may now view all assignments for a given user, regardless of
  # whether they're a part of that classroom
  def user_index
    @assignments = current_user.domain.users.find(params[:id])

    respond_to do |format|
      #format.html
      format.json { render :json => { :assignments => @assignments } }
    end
  end

  # GET /assignments/1
  def show
    respond_to do |format|
      #format.html
      format.json { render :json => @assignment }
    end
  end

  # GET /assignments/new
  def new
    @assignment = @project.assignments.build
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  def create
    @assignment = @project.assignments.build(assignment_params)

    respond_to do |format|
      if @assignment.save
        #format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render :json => @assignment }
      else
        #format.html { render :new }
        format.json { render :json => { :errors => @assignment.errors.full_messages }, :status => 422 }
      end
    end
  end

  # PATCH/PUT /assignments/1
  def update
    respond_to do |format|
      if @assignment.save
        #format.html { redirect_to @assignment, notice: 'Assignment was successfully updates.' }
        format.json { render :json => @assignment }
      else
        #format.html { render :edit }
        format.json { render :json => { :errors => @assignment.errors.full_messages }, :status => 422 }
      end
    end
  end

  # DELETE /assignments/1
  def destroy
    @assignment.destroy

    respond_to do |format|
      #format.html { redirect_to assignments, notice: 'Assignment was successfully destroyed.' }
      format.json { head 200 }
    end
  end

  private
    def set_project
      @project = current_user.projects.find(params[:project_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      if @project
        @assignment = @project.assignments.find(params[:id])
      else
        @assignment = current_user.assignments.find(params[:id])
      end
    end

    # Only allow a trusted parameter "white list" through.
    def assignment_params
      params[:assignment]
    end
end
