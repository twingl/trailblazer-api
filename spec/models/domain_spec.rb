require 'rails_helper'

RSpec.describe Domain, :type => :model do
  it "has accessors for the domain admin roles" do
    expect(subject).to have_many(:domain_admin_roles)
    expect(subject).to have_many(:admins).through(:domain_admin_roles)
  end
end
