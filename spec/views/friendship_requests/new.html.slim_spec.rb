require 'rails_helper'

RSpec.describe "friendship_requests/new", type: :view do
  before(:each) do
    assign(:friendship_request, FriendshipRequest.new(
      :user => nil,
      :friend => nil
    ))
  end

  it "renders new friendship_request form" do
    render

    assert_select "form[action=?][method=?]", friendship_requests_path, "post" do

      assert_select "input#friendship_request_user_id[name=?]", "friendship_request[user_id]"

      assert_select "input#friendship_request_friend_id[name=?]", "friendship_request[friend_id]"
    end
  end
end
