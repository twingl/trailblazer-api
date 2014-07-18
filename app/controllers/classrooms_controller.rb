class ClassroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_classroom, only: [:show, :edit, :update, :destroy, :enroll, :withdraw]

  # GET /classrooms
  def index
    if current_user.admin?
      @classrooms = current_user.domain.classrooms.all
    else
      @classrooms = current_user.classrooms.all
    end

    respond_to do |format|
      format.html
      format.json { render :json => { :classrooms => @classrooms } }
    end
  end

  # GET /classrooms/1
  def show
    respond_to do |format|
      format.html
      format.json { render :json => @classroom }
    end
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

    respond_to do |format|
      if @classroom.save
        @classroom.users << current_user
        format.html { redirect_to @classroom, notice: 'Classroom was successfully created.' }
        format.json { render :json => @classroom }
      else
        format.html { render :new }
        format.json { render :json => { :errors => @classroom.errors.full_messages }, :status => 422 }
      end
    end
  end

  # PATCH/PUT /classrooms/1
  def update
    respond_to do |format|
      if @classroom.update_attributes(classroom_params)
        format.html { redirect_to @classroom, notice: 'Classroom was successfully updates.' }
        format.json { render :json => @classroom }
      else
        format.html { render :edit }
        format.json { render :json => { :errors => @classroom.errors.full_messages }, :status => 422 }
      end
    end
  end

  # PUT/PATCH /classrooms/1/enroll
  def enroll
    users = current_user.domain.users.where(:id => enrollment_params.fetch(:users, []))

    @classroom.users = @classroom.users.to_a.concat(users.to_a)
    @classroom.reload

    render :json => { :users => @classroom.users }, :status => 200
  end

  # PUT/PATCH /classrooms/1/withdraw
  def withdraw
    users = current_user.domain.users.where(:id => enrollment_params.fetch(:users, []))

    @classroom.users.delete(users)

    render :json => { :users => @classroom.users }, :status => 200
  end

  # DELETE /classrooms/1
  def destroy
    @classroom.destroy
    respond_to do |format|
      format.html { redirect_to classrooms_url, notice: 'Classroom was successfully destroyed.' }
      format.json { head 200 }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      if current_user.admin?
        @classroom = current_user.domain.classrooms.find(params[:id])
      else
        @classroom = current_user.classrooms.find(params[:id])
      end
    end

    # Only allow a trusted parameter "white list" through.
    def classroom_params
      params.require(:classroom).permit(:name, :description)
    end

    def enrollment_params
      params.permit(:users => [])
    end
end
