require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has accessors for related models" do
    expect(subject).to have_many(:domain_admin_roles)
    expect(subject).to belong_to(:domain)
    expect(subject).to belong_to(:org_unit)
  end
end
