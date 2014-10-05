class TrailblazerAdmin::UsersController < TrailblazerAdmin::ApplicationController
  def ui
  end

  def search
    puts params[:q]
    results = User.where{|u| u.email =~ "%#{params[:q]}%"}.limit(8)
    render :json => { :users => results }
  end
end
