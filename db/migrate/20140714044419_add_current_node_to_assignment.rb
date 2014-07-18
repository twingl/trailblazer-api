class AddCurrentNodeToAssignment < ActiveRecord::Migration
  def change
    add_reference :assignments, :current_node, index: true
  end
end
