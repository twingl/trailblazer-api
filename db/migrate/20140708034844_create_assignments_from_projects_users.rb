class CreateAssignmentsFromProjectsUsers  < ActiveRecord::Migration
  def change
    rename_table :projects_users, :assignments

    add_column :assignments, :title, :string, :default => nil
    add_column :assignments, :completed_at, :datetime, :default => nil
    add_column :assignments, :started_at, :datetime, :default => nil
  end
end
