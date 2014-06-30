class AddOrgUnitPathToUser < ActiveRecord::Migration
  def change
    add_column :users, :org_unit_path, :string
  end
end
