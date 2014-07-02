class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :edit, :update, :destroy, :enroll, :withdraw]

  # GET /classrooms
  def index
    @classrooms = current_user.domain.classrooms.all
  end

  # GET /classrooms/1
  def show
  end

  # GET /classrooms/new
  def new
    @classroom = Classroom.new
  end

  # GET /classrooms/1/edit
  def edit
  end

  # POST /classrooms
  def create
    @classroom = current_user.domain.classrooms.build(classroom_params)

    if @classroom.save
      redirect_to @classroom, notice: 'Classroom was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /classrooms/1
  def update
    if @classroom.update(classroom_params)
      redirect_to @classroom, notice: 'Classroom was successfully updated.'
    else
      render :edit
    end
  end

  # PUT/PATCH /classrooms/1/enrol
  def enroll
    users = current_user.domain.users.where(:id => enrollment_params.fetch(:users, {}).fetch(:id, []))

    users.each do |u|
      begin
        @classroom.users << u
      rescue ActiveRecord::RecordNotUnique => e
        logger.warn("Duplicate enrollment skipped: User #{u.id}, Classroom #{@classroom.id}")
      end
    end
    render :json => { :users => @classroom.users }, :status => 200
  end

  # PUT/PATCH /classrooms/1/withdraw
  def withdraw
    users = current_user.domain.users.where(:id => enrollment_params.fetch(:users, {}).fetch(:id, []))

    users.each {|u| @classroom.users.delete(u) }

    render :json => { :users => @classroom.users }, :status => 200
  end

  # DELETE /classrooms/1
  def destroy
    @classroom.destroy
    redirect_to classrooms_url, notice: 'Classroom was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = current_user.domain.classrooms.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def classroom_params
      params.require(:classroom).permit(:name)
    end

    def enrollment_params
      params.permit(:users => { :id => [] })
    end
end
