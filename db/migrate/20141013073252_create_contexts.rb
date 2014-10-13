class CreateContexts < ActiveRecord::Migration
  def change
    create_table :contexts do |t|
      t.text :title
      t.text :url,              index: true
      t.text :provider,         index: true
      t.json :embedly_object

      t.timestamps
    end
  end
end
