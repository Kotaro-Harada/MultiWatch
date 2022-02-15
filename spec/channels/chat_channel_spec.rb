require 'rails_helper'

RSpec.describe ChatChannel, type: :channel do
  let(:room) { create(:room) }
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(ActionDispatch::Request).
      to receive(:session).and_return(user_id: user.id)
    stub_connection current_user: user
  end

  context "user has a room" do
    it "can subscribe" do
      subscribe(room_id: room.id)
      expect(subscription).to be_confirmed
    end
  end

  context "user does not have a room" do
    it "can not subscribe" do
      subscribe(room_id: nil)
      expect(subscription.streams).to eq ["ChatChannel_"]
    end
  end
end
