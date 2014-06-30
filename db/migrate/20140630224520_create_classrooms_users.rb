class CreateClassroomsUsers < ActiveRecord::Migration
  def change
    create_table :classrooms_users do |t|
      t.references :user
      t.references :classroom
    end
    add_index :classrooms_users, [:user_id, :classroom_id], :unique => true
    add_index :classrooms_users, [:classroom_id, :user_id], :unique => true
  end
end
