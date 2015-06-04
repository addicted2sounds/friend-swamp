class CreateFriendshipRequests < ActiveRecord::Migration
  def change
    create_table :friendship_requests do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :friend_id

      t.timestamps null: false
    end
    add_foreign_key :friendship_requests, :users, column: :friend_id
  end

end
