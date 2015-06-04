require 'rails_helper'

RSpec.describe FriendshipRequest, type: :model do
  describe '.status' do
    let(:request) { FriendshipRequest.new }
    it ':pending by default' do
      expect(request.status).to eq 'pending'
    end
  end

  describe '.relieve' do
    let(:request) { create :friendship_request }
    before :each do
      request.relieve!
    end

    it 'changes status to :relived' do
      expect(request.status).to eq 'relieved'
    end
  end
end
