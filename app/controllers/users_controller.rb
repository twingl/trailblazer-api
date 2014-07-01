class UsersController < ApplicationController

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

  def user_params
    params.permit(:users => [ :admin, :teacher, :active ])
  end
end
