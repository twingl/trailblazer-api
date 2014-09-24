require 'rails_helper'

RSpec.describe Project, :type => :model do
  it "has accessors for related models" do
    expect(subject).to belong_to(:classroom)
    expect(subject).to have_many(:assignments).dependent(:destroy)
    expect(subject).to have_many(:users).through(:assignments)
  end

  describe "#assign" do
    pending "it creates an assignment for each of the assignees"
  end

  describe "#assign_to" do
    pending "it should delegate to #assign"
  end
end
