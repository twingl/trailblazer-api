class OrgUnit < ActiveRecord::Base
  belongs_to :domain
  has_many :users
end
