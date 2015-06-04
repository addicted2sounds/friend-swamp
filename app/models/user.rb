class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friendship_requests
  has_many :inverse_friendship_request, class_name: 'FriendshipRequest', foreign_key: :friend_id

  has_many :friends, through: :friendship_requests
  has_many :inverse_friends, through: :inverse_friendship_request, source: :user

  def relieve_friend(user)

  end
end
