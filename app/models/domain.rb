class Domain < ActiveRecord::Base
  has_many :domain_admin_roles
  has_many :admins, :through => :domain_admin_roles, :source => :user
  has_many :org_units

  def imported?
    imported_at.present?
  end
end
