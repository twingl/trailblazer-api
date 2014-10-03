class Assignment < ActiveRecord::Base
  belongs_to :user, -> { uniq }
  belongs_to :project

  has_many :nodes, :dependent => :destroy
  has_one :current_node, :class_name => "Node"

  before_create :set_title_and_description

  before_save :set_token

  def as_json(options={})
    json = {
      :id               => self.id,
      :user_id          => self.user_id,
      :project_id       => self.project_id,
      :title            => self.title,
      :completed_at     => self.completed_at,
      :current_node_id  => self.current_node_id,
      :description      => self.description,
      :visible          => self.visible
    }

    if self.public_url_token.present? && visible
      json[:url] = Rails.application.routes.url_helpers.public_map_url(
        :token  => self.public_url_token,
        :host   => options.fetch(:host, "app.trailblazer.io"))
    end

    json
  end

  # This shouldn't be created directly - there is a helper method
  # `Project#assign` which accepts an array of users to achieve this.

  private

  def set_token
    if self.public_url_token.blank?
      token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless Assignment.exists?(:public_url_token => random_token)
      end
      self.public_url_token = token
    end
  end

  def set_title_and_description
    self.title       = project.title
    self.description = project.description
  end
end
