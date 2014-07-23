require 'rails_helper'

RSpec.describe TrailblazerAdmin, :type => :model do
  it "references a user" do
    expect(subject).to belong_to(:user)
  end
end
