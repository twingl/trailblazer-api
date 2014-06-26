require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

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
