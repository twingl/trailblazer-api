require 'rails_helper'

RSpec.describe Assignment, :type => :model do
  it "has accessors for related models" do
    expect(subject).to belong_to(:user)
    expect(subject).to belong_to(:project)
    expect(subject).to have_many(:nodes).dependent(:destroy)
    expect(subject).to have_one(:current_node)
  end
end
