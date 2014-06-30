class AddDomainToUser < ActiveRecord::Migration
  def change
    add_reference :users, :domain, index: true
  end
end
