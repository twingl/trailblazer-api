class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.references :classroom, index: true

      t.datetime :due_at
      t.boolean :visible

      t.timestamps
    end
  end
end
