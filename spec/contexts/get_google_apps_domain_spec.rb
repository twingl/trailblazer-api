require 'rails_helper'
require 'contexts/get_google_apps_domain'

RSpec.describe GetGoogleAppsDomain do
  let(:user) { FactoryGirl.create :user }
  let(:api_client_instance) do
    instance_double("ApiWrappers::Google", {
      :fetch_access_token! => nil,
      :directory_users_list => double("response", { :success? => true })
    })
  end

  before(:each) { allow(ApiWrappers::Google).to receive(:new).and_return(api_client_instance) }

  it "initializes the API wrapper with the user" do
    expect(ApiWrappers::Google).to receive(:new).with(user).and_return(api_client_instance)

    GetGoogleAppsDomain.new(:user => user, :domain_name => "example.com").call
  end

  it "fetches an access token" do
    expect(api_client_instance).to receive(:fetch_access_token!)

    GetGoogleAppsDomain.new(:user => user, :domain_name => "example.com").call
  end

  it "calls the directory api" do
    expect(api_client_instance).to receive(:directory_users_list).with("example.com")

    GetGoogleAppsDomain.new(:user => user, :domain_name => "example.com").call
  end

  context "with a successful response" do
    before(:each) do
      allow(api_client_instance).to receive(:directory_users_list).and_return(double("response", { :success? => true }))
    end

    context "without an existing domain" do
      it "creates a new domain" do
        expect {
          result = GetGoogleAppsDomain.new(:user => user, :domain_name => "example.com").call
          expect(result.domain).to eq("example.com")
        }.to change(Domain, :count).by(1)
      end

      it "creates a DomainAdminRole for the user" do
        expect {
          result = GetGoogleAppsDomain.new(:user => user, :domain_name => "example.com").call
          expect(result.admins).to include(user)
        }.to change(DomainAdminRole, :count).by(1)
      end
    end

    context "with an existing domain" do
      let!(:domain) { FactoryGirl.create :domain, :domain => "example.com" }

      it "returns the existing domain" do
        expect {
          result = GetGoogleAppsDomain.new(:user => user, :domain_name => "example.com").call
          expect(result).to eq(domain)
        }.to_not change(Domain, :count)
      end
    end

    it "returns the domain" do
      result = GetGoogleAppsDomain.new(:user => user, :domain_name => "example.com").call
      expect(result).to be_a(Domain)
    end
  end

  context "with an unsuccessful response" do
    before(:each) do
      allow(api_client_instance).to receive(:directory_users_list).and_return(double("response", { :success? => false }))
    end

    it "returns false" do
      result = GetGoogleAppsDomain.new(:user => user, :domain_name => "example.com").call
      expect(result).to eq(false)
    end
  end
end
