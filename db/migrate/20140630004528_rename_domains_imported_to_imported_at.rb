class RenameDomainsImportedToImportedAt < ActiveRecord::Migration
  def change
    rename_column :domains, :imported, :imported_at
  end
end
