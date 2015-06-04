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
end
