require 'rails_helper'

RSpec.describe User, type: :model do

  # describe 'scopes' do
  #   describe 'regular' do
  #     let(:user) { create :user }
  #     let(:friend) { create :user }
  #     it "doesn't include current user" do
  #       expect(User.regular(user.id)).not_to include user
  #     end
  #     it "include other users" do
  #       create :user
  #       p User.regular(user.id)
  #       # expect(User.regular(user.id).all).to include friend
  #     end
  #   end
  # end

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

    describe '.friendship_request_with' do
      context 'direct friendship' do
        subject { user.friendship_request_with(friend) }
        it { is_expected.to be_a_kind_of FriendshipRequest }
      end
      context 'inverse friendship' do
        subject { friend.friendship_request_with(user) }
        it { is_expected.to be_a_kind_of FriendshipRequest }
      end
    end

    describe '.is_a_friend_of?' do
      it { expect(user.is_a_friend_of?(friend)).to be_truthy }
      it { expect(friend.is_a_friend_of?(user)).to be_truthy }
    end

    describe '.has_friendship_request_from?' do
      it { expect(friend.has_friendship_request_from?(user)).to be_truthy }
    end

    describe '.has_friendship_request_to?' do
      it { expect(friend.has_friendship_request_from?(user)).to be_truthy }
    end
  end

  describe '.relieve_friend' do
    context 'direct releive' do
      it 'request is deleted' do
        request = create :friendship_request, status: :accepted
        expect{
          request.user.relieve_friend! request.friend
        }.to change(FriendshipRequest, :count).by -1
      end
    end
    context 'inverse releive' do
      it 'request is deleted' do
        request = create :friendship_request, status: :accepted
        expect{
          request.friend.relieve_friend! request.user
        }.to change(FriendshipRequest, :count).by -1
      end
    end
  end
end
