class User < ActiveRecord::Base

  has_secure_password :validations => false

  def should_validate_password?
    password.present?
  end
  validates_length_of :password, :minimum => 5, :if => :should_validate_password?

  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :confirmation_token, :allow_nil => true
  validates_uniqueness_of :reset_password_token, :allow_nil => true

  has_many :domain_admin_roles
  belongs_to :domain
  belongs_to :org_unit

  has_many :assignments, -> { uniq }, :dependent => :destroy
  has_many :projects, :through => :assignments
  has_many :nodes, :dependent => :destroy

  scope :admin,    -> { where(:admin    => true ) }
  scope :teacher,  -> { where(:teacher  => true ) }
  scope :student,  -> { where(:active   => true, :teacher => false, :admin => false) }
  scope :inactive, -> { where(:active   => false) }

  # Be wary: http://blog.spoolz.com/2014/05/20/rails-habtm-with-unique-scope-and-select-columns/
  has_and_belongs_to_many :classrooms, -> { uniq }

  def student?
    !admin? && !teacher? && active?
  end

  def as_json(options={})
    object = {
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

    object[:assignments] = assignments if options.fetch(:expand, []).include? :assignments
    object[:classrooms] = classrooms if options.fetch(:expand, []).include? :classrooms

    object
  end
end
