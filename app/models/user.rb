class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friendship_requests
  has_many :accepted_friendship_requests,
           -> { where status: FriendshipRequest.statuses[:accepted] },
           class_name: 'FriendshipRequest'
  has_many :friends, through: :accepted_friendship_requests, source: :user

  has_many :inverse_friendship_requests, class_name: 'FriendshipRequest', foreign_key: :friend_id
  has_many :accepted_inverse_friendship_requests,
           -> { where status: FriendshipRequest.statuses[:accepted] },
           class_name: 'FriendshipRequest', foreign_key: :friend_id
  has_many :inverse_friends, through: :accepted_inverse_friendship_requests, source: :user

  def self.regular(user_id)
    # joins(:friendship_requests, :inverse_friendship_requests)
    where.not(id: user_id)
      .includes(:friendship_requests).where.not('friendship_requests.user_id' => user_id)
  end

  def relieve_friend!(user)
    friendship_requests.where(friend_id: user.id).each do |request|
      request.relieve!
    end
    inverse_friendship_requests.where(user_id: user.id).each do |request|
      request.relieve!
    end
  end
end
