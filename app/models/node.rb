class Node < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :user
  belongs_to :parent, :class_name => "Node"
end
