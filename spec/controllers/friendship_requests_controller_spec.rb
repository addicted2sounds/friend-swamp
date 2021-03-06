require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe FriendshipRequestsController, type: :controller do
  describe 'GET #index' do
    let(:friendship_request) { create :friendship_request }
    before :each do
      sign_in friendship_request.friend
    end
    it 'assigns all users requested friendship as @users' do
      get :index
      expect(assigns(:friendship_requests)).to eq [friendship_request]
    end

    it 'includes request only for current user' do
      other_request = create :friendship_request
      get :index
      expect(assigns(:friendship_requests)).not_to include other_request
    end
  end

  describe 'PATCH #accept' do
    before :each do
      sign_in friendship_request.friend
    end
    let(:friendship_request) { create :friendship_request }
    it 'change request status to :accepted' do
      patch :accept, { id: friendship_request.to_param }
      friendship_request.reload
      expect(friendship_request.status).to eq 'accepted'
    end
  end

  describe 'PATCH #decline' do
    before :each do
      sign_in friendship_request.friend
    end
    let(:friendship_request) { create :friendship_request }
    it 'change request status to :declined' do
      # skip 'not sure why not working'
      patch :decline, { id: friendship_request.to_param }
      friendship_request.reload
      expect(friendship_request.status).to eq 'declined'
    end
  end

  describe 'DELETE #delete' do
    before :each do
      @friendship_request = create :friendship_request
      sign_in @friendship_request.user
    end
    it 'delete own request' do
      expect {
        delete :destroy, id: @friendship_request.to_param
      }.to change(FriendshipRequest, :count).by -1
    end
    it 'redirect when try to delete someone else request' do
      new_request = create :friendship_request
      expect {
        delete :destroy, id: new_request.to_param
      }.to raise_exception ActiveRecord::RecordNotFound
    end
  end
end
