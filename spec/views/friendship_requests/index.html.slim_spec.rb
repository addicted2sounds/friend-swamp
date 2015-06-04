require 'rails_helper'

RSpec.describe "friendship_requests/index", type: :view do
  before(:each) do
    assign(:friendship_requests, [
      FriendshipRequest.create!(
        :user => nil,
        :friend => nil
      ),
      FriendshipRequest.create!(
        :user => nil,
        :friend => nil
      )
    ])
  end

  it "renders a list of friendship_requests" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
