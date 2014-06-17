class PagesController < ApplicationController
  before_filter :authenticate_user!, :only => :dashboard
  def dashboard
  end

  def sign_in
  end
end
