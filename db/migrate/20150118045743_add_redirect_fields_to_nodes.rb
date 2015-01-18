class AddRedirectFieldsToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :redirect, :boolean
    add_column :nodes, :redirected_to, :text
  end
end
