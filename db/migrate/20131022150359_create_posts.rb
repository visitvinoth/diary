class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.datetime, :entry_date
      t.text, :entry_text
      t.integer :user_id

      t.timestamps
    end
  end
end
