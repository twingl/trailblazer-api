class AddCoordinatesToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :x, :float
    add_column :nodes, :y, :float
  end
end
