class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :domain
      t.datetime :imported
      t.boolean :importing

      t.timestamps
    end

    add_index :domains, :domain
  end
end
