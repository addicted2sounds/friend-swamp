require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'friends' do
    let(:request) { create :friendship_request, status: :accepted }
    it 'has friend through request' do
      expect(request.user.friends).to include request.friend
    end

    it 'has friend through request (inverse)' do
      expect(request.friend.inverse_friends).to include request.user
    end
  end

  describe '.relieve_frien' do
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
