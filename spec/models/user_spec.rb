require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has accessors for related models" do
    expect(subject).to have_many(:domain_admin_roles)
    expect(subject).to belong_to(:domain)
    expect(subject).to belong_to(:org_unit)
    expect(subject).to have_many(:assignments)
    expect(subject).to have_and_belong_to_many(:classrooms)
    expect(subject).to have_many(:projects).through(:classrooms)
  end

  describe "#student?" do
    it "is true when an active user is not a teacher or admin" do
      expect(User.new(:active => true).student?).to eq true
    end

    it "is false when a user is an admin or teacher" do
      expect(User.new(:admin => true).student?).to eq false
      expect(User.new(:teacher => true).student?).to eq false
    end
  end
end
