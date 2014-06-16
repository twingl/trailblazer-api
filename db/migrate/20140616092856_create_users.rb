class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid, :unique => true, :null => false
      t.string :name
      t.string :email
      t.string :access_token
      t.datetime :token_expires

      t.timestamps
    end
  end
end
