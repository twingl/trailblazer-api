require 'contexts/get_oauth_user'
require 'contexts/get_google_apps_domain'

class PagesController < ApplicationController
  skip_before_action :authenticate_valid_account!, :only => [:inactive, :coming_soon]

  # GET /landing
  # GET /
  def landing
  end

  # Page shown to signed in users who are not marked as +active+
  #
  # GET /inactive
  def inactive
  end

  # Page shown to users who don't meet the requirements to use Trailblazer yet.
  # Currently this is just anyone who isn't part of a domain.
  #
  # GET /coming_soon
  def coming_soon
  end

  # Container for angular requests
  #
  # GET /*path
  def angular
  end
end
