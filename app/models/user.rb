class User < ActiveRecord::Base
  has_many :domain_admin_roles
end
