class Node < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :user
  belongs_to :parent, :class_name => "Node"

  belongs_to :context

  after_create :schedule_work

  validates :rank, :numericality => {
    :less_than_or_equal_to    => 1,
    :greater_than_or_equal_to => -1
  }

  delegate :favicon_url, :to => :context, :allow_nil => true

private

  def schedule_work
    # Enqueue a worker to extract information about this Node
    ExtractWebsiteInformationJob.perform_later self
  end
end
