class ChangeUrlAndTitleToText < ActiveRecord::Migration
  def up
    change_column :nodes, :url, :text
    change_column :nodes, :title, :text
  end

  def down
    change_column :nodes, :url, :string
    change_column :nodes, :title, :string
  end
end
