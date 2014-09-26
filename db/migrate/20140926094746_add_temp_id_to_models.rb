class AddTempIdToModels < ActiveRecord::Migration
  def change
    add_column :nodes,       :temp_id, :string, :default => nil
    add_column :assignments, :temp_id, :string, :default => nil
  end
end
