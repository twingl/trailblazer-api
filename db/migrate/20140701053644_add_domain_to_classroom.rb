class AddDomainToClassroom < ActiveRecord::Migration
  def change
    add_reference :classrooms, :domain, index: true
  end
end
