class Project < ActiveRecord::Base
  belongs_to :classroom

  attr_accessor :auto_assign

  has_many :assignments, :dependent => :destroy
  has_many :users, :through => :assignments

  after_create :assign, :if => Proc.new {|u| u.auto_assign and u.classroom_id.present? }

  def assign(assignees = classroom.users.student)
    ActiveRecord::Base.transaction do
      assignees.each do |u|
        assignments.create(:user => u)
      end
    end
  end
end
