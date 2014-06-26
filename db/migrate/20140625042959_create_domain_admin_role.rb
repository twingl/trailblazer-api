class CreateDomainAdminRole < ActiveRecord::Migration
  def change
    create_table :domain_admin_roles do |t|
      t.references :user, index: true
      t.references :domain, index: true
    end
  end
end
