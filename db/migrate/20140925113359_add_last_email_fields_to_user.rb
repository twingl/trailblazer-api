class AddLastEmailFieldsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string   :last_email
      t.datetime :last_confirmed_at
    end
  end
end
