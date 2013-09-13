class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content
      t.string :link
      t.integer :vote_count
      t.integer :user_id

      t.timestamps
    end
  end
end
