class Node < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :user
  belongs_to :parent, :class_name => "Node"

  belongs_to :context

  before_create :schedule_work

  validates :rank, :numericality => {
    :less_than_or_equal_to    => 1,
    :greater_than_or_equal_to => -1
  }

private

  def schedule_work
    # Enqueue a worker to extract information about this Node
    Resque.enqueue(Workers::ExtractContextData, self.id)
  end
end
