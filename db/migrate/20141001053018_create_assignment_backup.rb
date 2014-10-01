class CreateAssignmentBackup < ActiveRecord::Migration
  def change
    create_table :assignment_backups do |t|
      t.references :user, index: true
      t.text :backup
    end
  end
end
