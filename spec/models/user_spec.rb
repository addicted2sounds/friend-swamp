require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'friends' do
    let(:request) { create :friendship_request, status: :accepted }
    let(:user) { request.user }
    let(:friend) { request.friend }
    it 'accepted_friendship_requests works!' do
      expect(user.accepted_friendship_requests).to eq [request]
    end
    it 'has friend through request' do
      expect(user.friends.first.id).to eq user.id
    end

    it 'inverse_accepted_friendship_requests works!' do
      expect(friend.accepted_inverse_friendship_requests).to eq [request]
    end

    it 'has inverse friend through request' do
      expect(friend.inverse_friends.first.id).to eq user.id
    end
  end

  describe '.relieve_friend' do
    let(:request) { create :friendship_request, status: :accepted }
    context 'direct releive' do
      before :each do
        request.user.relieve_friend! request.friend
      end
      it 'request is relieved' do
        request.reload
        expect(request.status).to eq 'relieved'
      end
    end
    context 'inverse releive' do
      before :each do
        request.friend.relieve_friend! request.user
      end
      it 'request is relieved' do
        request.reload
        expect(request.status).to eq 'relieved'
      end
    end
  end
end
