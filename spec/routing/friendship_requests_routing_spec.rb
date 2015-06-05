require "rails_helper"

RSpec.describe FriendshipRequestsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/friendship_requests").to route_to("friendship_requests#index")
    end

    it "routes to #new" do
      expect(:get => "/friendship_requests/new").to route_to("friendship_requests#new")
    end

    it "routes to #show" do
      expect(:get => "/friendship_requests/1").to route_to("friendship_requests#show", :id => "1")
    end

    # it "routes to #edit" do
    #   expect(:get => "/friendship_requests/1/edit").to route_to("friendship_requests#edit", :id => "1")
    # end

    it "routes to #create" do
      expect(:post => "/friendship_requests").to route_to("friendship_requests#create")
    end

    # it "routes to #update" do
    #   expect(:put => "/friendship_requests/1").to route_to("friendship_requests#update", :id => "1")
    # end

    it "routes to #destroy" do
      expect(:delete => "/friendship_requests/1").to route_to("friendship_requests#destroy", :id => "1")
    end

    it 'routes to #accept' do
      expect(patch: '/friendship_requests/1/accept').to route_to('friendship_requests#accept', :id => '1')
    end

    it 'routes to #decline' do
      expect(patch: '/friendship_requests/1/decline').to route_to('friendship_requests#decline', :id => '1')
    end

    it 'routes to #outgoing' do
      expect(get: '/friendship_requests/outgoing').to route_to('friendship_requests#outgoing')
    end
  end
end
