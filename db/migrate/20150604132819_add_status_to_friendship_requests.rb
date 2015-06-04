class AddStatusToFriendshipRequests < ActiveRecord::Migration
  def change
    add_column :friendship_requests, :status, :integer, default: 0
  end
end
