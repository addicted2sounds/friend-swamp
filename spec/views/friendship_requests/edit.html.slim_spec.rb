require 'rails_helper'

RSpec.describe "friendship_requests/edit", type: :view do
  before(:each) do
    @friendship_request = assign(:friendship_request, FriendshipRequest.create!(
      :user => nil,
      :friend => nil
    ))
  end

  it "renders the edit friendship_request form" do
    render

    assert_select "form[action=?][method=?]", friendship_request_path(@friendship_request), "post" do

      assert_select "input#friendship_request_user_id[name=?]", "friendship_request[user_id]"

      assert_select "input#friendship_request_friend_id[name=?]", "friendship_request[friend_id]"
    end
  end
end
