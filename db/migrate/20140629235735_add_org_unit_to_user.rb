class AddOrgUnitToUser < ActiveRecord::Migration
  def change
    add_reference :users, :org_unit, index: true
  end
end
