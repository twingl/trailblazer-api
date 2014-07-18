class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.references :assignment, index: true
      t.references :user, index: true
      t.references :parent, index: true
      t.string :url, null: false
      t.string :title
      t.datetime :arrived_at
      t.datetime :departed_at
      t.boolean :idle, default: false

      t.timestamps
    end
  end
end
