class CreateOrgUnits < ActiveRecord::Migration
  def change
    create_table :org_units do |t|
      t.references :domain
      t.string :name
      t.string :org_unit_path
      t.string :parent_org_unit_path
      t.text   :description

      t.timestamps
    end
  end
end
