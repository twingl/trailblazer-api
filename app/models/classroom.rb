class Classroom < ActiveRecord::Base
  # Be wary: http://blog.spoolz.com/2014/05/20/rails-habtm-with-unique-scope-and-select-columns/
  has_and_belongs_to_many :users, -> { uniq }

  def students
    users.where(:active => true, :teacher => false, :admin => false)
  end

  def teachers
    users.where(:teacher => true)
  end
end
