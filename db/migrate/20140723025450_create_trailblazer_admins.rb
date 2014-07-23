class CreateTrailblazerAdmins < ActiveRecord::Migration
  def change
    create_table :trailblazer_admins do |t|
      t.references :user

      t.timestamps
    end
  end
end
