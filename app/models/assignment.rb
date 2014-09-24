class Assignment < ActiveRecord::Base
  belongs_to :user, -> { uniq }
  belongs_to :project

  has_many :nodes, :dependent => :destroy
  has_one :current_node, :class_name => "Node"

  before_create :set_title_and_description

  # This shouldn't be created directly - there is a helper method
  # `Project#assign` which accepts an array of users to achieve this.

  private

  def set_title_and_description
    self.title       = project.title
    self.description = project.description
  end
end
