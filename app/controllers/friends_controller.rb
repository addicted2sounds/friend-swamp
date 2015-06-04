class FriendsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend, only: [:relieve]
  # GET /friends
  def index
    @user = current_user
  end

  # POST /friends/:id/relieve
  def relieve
    current_user.relieve_friend!(@friend)
    respond_to do |format|
      format.html { redirect_to friends_path, notice: 'Friendship is gone' }
    end
  end

  private

  def set_friend
    @friend = User.find(params[:id])
  end
end
