class FriendshipRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  enum status: [:pending, :accepted, :declined, :relieved]
  validates_uniqueness_of :user_id, scope: :friend_id,
            message: 'Already have requested friendship of this user'
  validate :friend_id, :has_incoming_request

  def has_incoming_request
    if self.class.exists?(friend_id: user_id, user_id: friend_id)
      errors.add(:friend_id, :already_have_request_from_that_user)
    end
  end
  def relieve!
    self.destroy
  end

end
