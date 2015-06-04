require 'rails_helper'

RSpec.describe "FriendshipRequests", type: :request do
  describe "GET /friendship_requests" do
    it "works! (now write some real specs)" do
      get friendship_requests_path
      expect(response).to have_http_status(200)
    end
  end
end
