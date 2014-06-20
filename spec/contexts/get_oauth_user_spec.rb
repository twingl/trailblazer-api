require 'rails_helper'
require 'contexts/get_oauth_user'

RSpec.describe GetOauthUser do
  let(:service_hash) { YAML.load(read_fixture('omniauth/google_apps.yml')) }

  before(:each) { @context = GetOauthUser.new(:service_hash => service_hash) }

  context "with an existing user" do
    let!(:user) { FactoryGirl.create :user, :uid => service_hash["uid"] }

    it "finds an existing user" do
      expect{ @user = @context.call }.to change(User, :count).by 0
      expect(@user).to eq user
    end
  end

  context "without an existing user" do
    it "returns a new, inactive user" do
      expect{ @user = @context.call }.to change(User, :count).by 1

      expect(@user).to be_a User
      expect(@user.uid).to eq service_hash["uid"]
      expect(@user.active).to eq false
    end
  end
end
