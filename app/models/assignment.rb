class Assignment < ActiveRecord::Base
  belongs_to :user, -> { uniq }
  belongs_to :project

  has_many :nodes
  has_one :current_node, :class_name => "Node"

  # This shouldn't be created directly - there is a helper method
  # `Project#assign` which accepts an array of users to achieve this.
end
