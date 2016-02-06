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

  # Page shown to users who don't meet the requirements to use Trailblazer yet.
  # Currently this is just anyone who isn't part of a domain.
  #
  # GET /coming_soon
  def coming_soon
  end

  # Shows the feedback form
  # GET /feedback
  def feedback
  end

  # Shows the bug report form
  # GET /bug
  def bug
  end
end
