class AddAuthFieldsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string    :password_digest,           :default => nil

      t.string    :reset_password_token
      t.datetime  :reset_password_sent_at

      t.integer   :sign_in_count,             :default => 0, :null => false
      t.datetime  :current_sign_in_at
      t.datetime  :last_sign_in_at
      t.string    :current_sign_in_ip
      t.string    :last_sign_in_ip

      t.string    :confirmation_token
      t.datetime  :confirmed_at
      t.datetime  :confirmation_sent_at

    end

    add_index :users, :reset_password_token,  :unique => true
    add_index :users, :confirmation_token,    :unique => true
  end
end
