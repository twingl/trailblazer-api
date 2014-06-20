require 'rails_helper'
require 'contexts/get_oauth_user'

RSpec.describe SessionsController, :type => :controller do

  let(:user) { FactoryGirl.create :user }

  describe "GET 'create_google'" do
    context "with a valid user" do
      before(:each) { expect_any_instance_of(GetOauthUser).to receive(:call).and_return(user) }

      it "establishes a session for the user" do
        expect(controller).to receive(:establish_session).once.with(user)
        get 'create_google'
      end

      it "redirects to the return location" do
        controller.send(:store_location, "test")
        get 'create_google'
        expect(response).to redirect_to "test"
      end
    end

    context "without a valid user" do
      before(:each) { expect_any_instance_of(GetOauthUser).to receive(:call).and_return(false) }

      it "redirects to the landing page" do
        expect(controller).to_not receive(:establish_session)
        get 'create_google'
        expect(response).to redirect_to landing_url
      end
    end
  end

  describe "GET 'destroy'" do
    before(:each) { controller.send(:establish_session, user) }
    it "signs out the current user" do
      get 'destroy'
      expect(controller.send(:current_user)).to be_nil
    end

    it "redirects to the landing page" do
      get 'destroy'
      expect(response).to redirect_to landing_url
    end
  end

end
