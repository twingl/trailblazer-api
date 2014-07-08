class User < ActiveRecord::Base
  has_many :domain_admin_roles
  belongs_to :domain
  belongs_to :org_unit

  has_many :assignments, -> { uniq }

  scope :admin,    -> { where(:admin    => true ) }
  scope :teacher,  -> { where(:teacher  => true ) }
  scope :student,  -> { where(:active   => true, :teacher => false, :admin => false) }
  scope :inactive, -> { where(:active   => false) }

  # Be wary: http://blog.spoolz.com/2014/05/20/rails-habtm-with-unique-scope-and-select-columns/
  has_and_belongs_to_many :classrooms, -> { uniq }
  has_many :projects, :through => :classrooms

  def student?
    !admin? && !teacher? && active?
  end

  def as_json(options={})
    {
      :id => id,
      :google_profile => google_profile,
      :name => name,
      :first_name => first_name,
      :last_name => last_name,
      :email => email,
      :image => image,
      :active => active,
      :admin => admin,
      :teacher => teacher,
      :created_at => created_at,
      :updated_at => updated_at
    }
  end
end
