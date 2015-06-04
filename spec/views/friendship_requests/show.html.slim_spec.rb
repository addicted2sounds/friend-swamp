require 'rails_helper'

RSpec.describe "friendship_requests/show", type: :view do
  before(:each) do
    @friendship_request = assign(:friendship_request, FriendshipRequest.create!(
      :user => nil,
      :friend => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
