class DomainAdminRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :domain
end
