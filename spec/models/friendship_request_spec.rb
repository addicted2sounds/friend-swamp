require 'rails_helper'

RSpec.describe FriendshipRequest, type: :model do
  describe '.status' do
    let(:request) { FriendshipRequest.new }
    it ':pending by default' do
      expect(request.status).to eq 'pending'
    end
  end

  describe '.relieve' do
    it 'deletes request' do
      request = create :friendship_request
      expect {
        request.relieve!
      }.to change(FriendshipRequest, :count).by -1
    end
  end

  describe 'uniqueness of friendship' do
    let(:request) { create :friendship_request }
    let(:user) { request.user }
    let(:friend) { request.friend }
    context 'user already sent request' do
      it 'fails validation' do
        new_request = build(:friendship_request, user_id: user.id, friend_id: friend.id)
        expect(new_request.valid?).to be_falsey
      end
    end
    context 'user has already received request from that' do
      it 'fails validation' do
        new_request = build(:friendship_request, friend_id: user.id, user_id: friend.id)
        expect(new_request.valid?).to be_falsey
      end
    end
  end
end
