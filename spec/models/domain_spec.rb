require 'rails_helper'

RSpec.describe Domain, :type => :model do
  it "has accessors for related models" do
    expect(subject).to have_many(:domain_admin_roles)
    expect(subject).to have_many(:admins).through(:domain_admin_roles)
    expect(subject).to have_many(:org_units)
  end
end
