require 'rails_helper'

RSpec.describe DomainsController, :type => :controller do

  describe "GET 'configure'" do
    context "signed in" do
      let(:user) { FactoryGirl.create :user }

      before(:each) { sign_in user }

      it "builds a GetGoogleAppsDomain" do
        expected_params = { :user => user, :domain_name => "example.com" }
        expect(GetGoogleAppsDomain).to receive(:new).with(expected_params).and_return(double(:call => nil))

        get :configure, :domain_name => "example.com"
      end

      it "assigns the domain" do
        domain = double
        expect_any_instance_of(GetGoogleAppsDomain).to receive(:call).and_return(domain)

        get :configure, :domain_name => "foo"

        expect(assigns(:domain)).to eq domain
      end
    end

    context "not signed in" do
      it "redirects to the landing page" do
        get 'configure', :domain_name => "foo"
        expect(response).to redirect_to '/auth/google_apps'
      end
    end
  end
end
