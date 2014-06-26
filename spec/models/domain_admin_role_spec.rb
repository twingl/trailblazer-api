require 'rails_helper'

RSpec.describe DomainAdminRole, :type => :model do
  it "has accessors for joined models" do
    expect(subject).to belong_to(:user)
    expect(subject).to belong_to(:domain)
  end
end
