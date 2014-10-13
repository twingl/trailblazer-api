class AddContextReferenceToNode < ActiveRecord::Migration
  def change
    add_reference :nodes, :context, index: true
  end
end
