module Workers
  class UpdateCoords

    @queue = :update_coords

    def self.perform(user_id, assignment_id, coords)
      coords      = ActiveSupport::HashWithIndifferentAccess.new(coords)
      user        = User.find(user_id)
      assignment  = user.assignments.find(assignment_id)

      ActiveRecord::Base.transaction do
        assignment.nodes.find(coords.keys).each do |n|
          n.update_attributes(coords[n.id.to_s].slice(:x, :y))
        end
      end
    end
  end
end
