class Node < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :user
  belongs_to :parent, :class_name => "Node"

  before_create :get_title

  belongs_to :context

  validates :rank, :numericality => {
    :less_than_or_equal_to    => 1,
    :greater_than_or_equal_to => -1
  }

private

  def get_title # Grab the title from another node if present
    node = Node.where("title IS NOT NULL").find_by(:url => url)
    if node
      self.title = node.title
    end
  end
end
