class RenameRedirectedToToRedirectedFrom < ActiveRecord::Migration
  def change
    rename_column :nodes, :redirected_to, :redirected_from
  end
end
