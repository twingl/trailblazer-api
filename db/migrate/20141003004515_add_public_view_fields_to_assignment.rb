class AddPublicViewFieldsToAssignment < ActiveRecord::Migration
  def change

    add_column :assignments, :public_url_token, :text, :index => true, :unique => true
    add_column :assignments, :visible, :boolean, :default => false
  end
end
