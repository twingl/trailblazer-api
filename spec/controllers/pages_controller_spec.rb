require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  describe "GET 'configure'" do
    context "signed in" do
      pending
    end

    context "not signed in" do
      it "redirects to the landing page" do
        get 'configure'
        expect(response).to redirect_to '/auth/google_apps'
      end
    end
  end

  describe "GET 'landing'" do
    it "returns http success" do
      get 'landing'
      expect(response).to be_success
    end
  end

  describe "GET 'inactive'" do
    it "returns http success" do
      get 'inactive'
      expect(response).to be_success
    end
  end
end
