require 'rails_helper'

RSpec.describe FriendshipRequest, type: :model do
  describe '.status' do
    let(:request) { FriendshipRequest.new }
    it ':pending by default' do
      expect(request.status).to eq 'pending'
    end
  end
end
