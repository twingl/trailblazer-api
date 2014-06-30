class User < ActiveRecord::Base
  has_many :domain_admin_roles
  belongs_to :domain
  belongs_to :org_unit

  # Be wary: http://blog.spoolz.com/2014/05/20/rails-habtm-with-unique-scope-and-select-columns/
  has_and_belongs_to_many :classrooms, -> { uniq }

  def student?
    !admin? && !teacher? && active?
  end
end
