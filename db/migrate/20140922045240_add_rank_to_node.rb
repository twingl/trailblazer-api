class AddRankToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :rank, :integer, :default => 0
  end
end
