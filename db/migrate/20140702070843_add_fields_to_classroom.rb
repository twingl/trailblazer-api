class AddFieldsToClassroom < ActiveRecord::Migration
  def change
    add_column :classrooms, :description, :text
    add_column :classrooms, :group_key, :string, index: true
  end
end
