require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has accessors for the domain admin roles" do
    expect(subject).to have_many(:domain_admin_roles)
  end
end
