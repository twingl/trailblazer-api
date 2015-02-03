class AddFaviconUrlToContext < ActiveRecord::Migration
  def change
    add_column :contexts, :favicon_url, :text
  end
end
