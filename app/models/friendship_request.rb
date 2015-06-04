class FriendshipRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  enum status: [:pending, :accepted, :declined, :relieved]

  def relieve!
    update_attribute(:status, :relieved)
  end
end
