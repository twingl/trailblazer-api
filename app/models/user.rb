class User < ActiveRecord::Base
  has_many :domain_admin_roles
  belongs_to :domain
  belongs_to :org_unit

  def student?
    !admin? && !teacher? && active?
  end
end
