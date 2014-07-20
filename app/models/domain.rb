class Domain < ActiveRecord::Base
  has_many :domain_admin_roles
  has_many :admins, :through => :domain_admin_roles, :source => :user
  has_many :users
  has_many :classrooms
  has_many :projects, :through => :classrooms
  has_many :org_units

  def imported?
    imported_at.present?
  end

  def to_param
    domain
  end
end
