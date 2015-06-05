require 'rails_helper'

RSpec.describe 'friendship_requests/index', type: :view do
  let(:friendship_request) { create :friendship_request}
  before(:each) do
    sign_in friendship_request.friend
    assign(:friendship_requests, FriendshipRequest.all)
    render
  end

  it 'includes user email in table' do
    expect(rendered).to have_selector 'tr>td', :text => friendship_request.user.email, :count => 1
  end

  it 'has show link' do

  end
end
