require 'rails_helper'

RSpec.describe OrgUnit, :type => :model do
  it "has accessors for related models" do
    expect(subject).to belong_to(:domain)
    expect(subject).to have_many(:users)
  end
end
