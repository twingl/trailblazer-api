class TrailblazerAdmin::UsersController < TrailblazerAdmin::ApplicationController
  def ui
  end

  def search
    puts params[:q]
    results = User.where("email LIKE ?", "%#{params[:q]}%").limit(8)
    render :json => { :users => results }
  end
end
