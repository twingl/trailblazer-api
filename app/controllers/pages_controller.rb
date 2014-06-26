require 'contexts/get_oauth_user'
require 'contexts/get_google_apps_domain'

class PagesController < ApplicationController

  # GET /landing
  # GET /
  def landing
  end

  # Page shown to signed in users who are not marked as +active+
  #
  # GET /inactive
  def inactive
  end
end
