class Classroom < ActiveRecord::Base
  # Be wary: http://blog.spoolz.com/2014/05/20/rails-habtm-with-unique-scope-and-select-columns/
  has_and_belongs_to_many :users, -> { uniq }
  belongs_to :domain

  validates_presence_of :name
end
