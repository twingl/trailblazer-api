require 'rails_helper'
require 'contexts/get_sign_in_method'

RSpec.describe GetSignInMethod do

  context "with an existing oauth user" do
    let!(:user) { FactoryGirl.create :user, :uid => "some_uid_from_oauth_provider" }

    it "returns 'oauth'" do
      @path = GetSignInMethod.new(:email => user.email).call
      expect(@path).to eq 'oauth'
    end
  end

  context "with an existing password user" do
    let!(:user) { FactoryGirl.create :user, :uid => nil }

    it "returns 'password'" do
      @path = GetSignInMethod.new(:email => user.email).call
      expect(@path).to eq 'password'
    end
  end

  context "without an existing user" do
    it "returns 'sign_up'" do
      @path = GetSignInMethod.new(:email => "something invalid").call
      expect(@path).to eq 'sign_up'
    end
  end
end
