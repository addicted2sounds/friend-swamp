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
    eager_load(:friendship_requests, :inverse_friendship_requests)
      .where.not(id: user_id)
  end

  def relieve_friend!(user)
    friendship_requests.where(friend_id: user.id).each do |request|
      request.relieve!
    end
    inverse_friendship_requests.where(user_id: user.id).each do |request|
      request.relieve!
    end
  end

  def friendship_request_with(user)
    friendship_requests.where(user_id: self.id, friend_id: user.id).first ||
        inverse_friendship_requests.where(friend_id: self.id, user_id: user.id).first
  end

  def is_a_friend_of?(user)
    accepted_friendship_requests.where(friend_id: user.id).any? ||
        accepted_inverse_friendship_requests.where(user_id: user.id).any?
  end

  def has_friendship_request_from?(user)
    inverse_friendship_requests.where(user_id: user.id).any?
  end

  def has_friendship_request_to?(user)
    friendship_requests.where(friend_id: user.id).any?
  end
end
