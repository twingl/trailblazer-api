require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do

  let(:user)  { FactoryGirl.create :user }
  let(:admin) { FactoryGirl.create :user, :admin => true }

  describe "#current_user" do
    it "returns the signed in user" do
      controller.session[:user_id] = user.id

      expect(User).to receive(:find_by_id).with(user.id).and_return user
      expect(controller.send(:current_user)).to eq user
    end

    it "caches the signed in user" do
      controller.session[:user_id] = user.id

      expect(User).to receive(:find_by_id).once.and_return user
      3.times { expect(controller.send(:current_user)).to eq user }
    end
  end

  describe "#establish_session" do
    it "assigns the current user" do
      controller.send(:establish_session, user)
      expect(assigns[:current_user]).to eq user
    end

    it "stores user_id in the session" do
      controller.send(:establish_session, user)
      expect(session[:user_id]).to eq user.id
    end

    it "clears the session if nil is passed" do
      controller.send(:establish_session, nil)
      expect(session[:user_id]).to be_nil
      expect(assigns[:current_user]).to be_nil
    end
  end

  describe "#destroy_session" do
    it "clears the session" do
      expect(session).to receive(:clear).once
      controller.send(:destroy_session)
    end

    it "sets @current_user to nil" do
      controller.send(:destroy_session)
      expect(assigns[:current_user]).to be_nil
    end
  end

  describe "#user_signed_in?" do
    it "returns true if a user is signed in" do
      controller.send(:establish_session, user)
      expect(controller.send(:user_signed_in?)).to eq true
    end

    it "returns false when no user is signed in" do
      controller.send(:destroy_session)
      expect(controller.send(:user_signed_in?)).to eq false
    end
  end

  describe "#admin_signed_in?" do
    it "returns true if the user is an admin" do
      controller.send(:establish_session, admin)
      expect(controller.send(:admin_signed_in?)).to eq true
    end

    it "returns false if the user is not an admin" do
      controller.send(:establish_session, user)
      expect(controller.send(:admin_signed_in?)).to eq false
    end
  end

  describe "#authenticate_user!" do
    controller do
      before_action :authenticate_user!

      def index
        render :status => 200, :nothing => true
      end
    end

    it "does nothing if a user is signed in" do
      controller.send(:establish_session, user)
      get 'index'
      expect(response).to be_success
    end

    it "redirects to the sign in path if no user is signed in" do
      get 'index'
      expect(response).to redirect_to sign_in_url
    end

    it "stores the return location" do
      expect(controller).to receive(:store_location)
      get 'index'
    end
  end

  describe "#authenticate_active_user!" do
    controller do
      before_action :authenticate_active_user!

      def index
        render :status => 200, :nothing => true
      end
    end

    it "falls back to #authenticate_user! if a user is not signed in" do
      expect(controller).to receive(:authenticate_user!).once.and_call_original
      get 'index'
    end

    it "does nothing if a user is active" do
      user.update_attribute(:active, true)

      controller.send(:establish_session, user)
      get 'index'
      expect(response).to be_success
    end

    it "redirects to the inactive page if a user is not active" do
      controller.send(:establish_session, user)
      get 'index'
      expect(response).to redirect_to inactive_url
    end
  end

  describe "#store_location" do
    before(:each) { controller.send(:store_location, "some path") }

    it "stores the return location in the session" do
      expect(session["user_return_to"]).to eq "some path"
    end

    it "doesn't overwrite the return location by default" do
      controller.send(:store_location, "new path")
      expect(session["user_return_to"]).to eq "some path"
    end

    it "allows a previous location to be overridden" do
      controller.send(:store_location, "new path", true)
      expect(session["user_return_to"]).to eq "new path"
    end
  end

  describe "#return_location" do
    before(:each) { controller.send(:store_location, "some path") }

    it "returns the stored location" do
      expect(controller.send(:return_location)).to eq "some path"
    end

    it "clears the location from the session" do
      controller.send(:return_location)
      expect(session["user_return_to"]).to be_nil
    end
  end
end
