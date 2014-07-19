class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parent, :only => [:index, :students, :teachers, :search]

  def me
    render :json => current_user.to_json(:expand => [:assignments, :classrooms])
  end

  def students
    @users = @parent.users.student

    respond_to do |format|
      format.json { render :json => { :users => @users } }
    end
  end

  def teachers
    @users = @parent.users.teacher

    respond_to do |format|
      format.json { render :json => { :users => @users } }
    end
  end

  def search
    term = "%#{params[:q]}%"
    @users = @parent.users.where("lower(name) LIKE lower(?) OR lower(email) LIKE lower(?)", term, term)

    respond_to do |format|
      format.json { render :json => { :users => @users } }
    end
  end

  def index
    @users = @parent.users

    respond_to do |format|
      format.html
      format.json { render :json => { :users => @users } }
    end
  end

  # POST /users/update_roles
  def update_roles
    authorize! :assign_roles, current_user

    ActiveRecord::Base.transaction do
      user_params[:users].each do |id, roles|
        User.find(id.to_i).update_attributes(roles)
      end
    end

    redirect_to configure_domain_path(current_user.domain)
  end

private

  def set_parent
    if params.has_key? :classroom_id
      @parent = current_user.domain.classrooms.find(params[:classroom_id])
    else
      @parent = current_user.domain
    end
  end

  def user_params
    params.permit(:users => [ :admin, :teacher, :active ])
  end
end
