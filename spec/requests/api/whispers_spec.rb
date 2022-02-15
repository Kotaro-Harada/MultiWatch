require 'rails_helper'

RSpec.describe "Api::Whispers", type: :request do
  let!(:user1) { create(:user, :with_whisper_room) }
  let!(:user2) { create(:user, :second) }

  before do
    allow_any_instance_of(ActionDispatch::Request).
      to receive(:session).and_return(user_id: user1.id)
  end

  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/whispers"
      expect(response).to have_http_status(200)
      expect(response.body).to include("multiwatch")
    end
  end

  describe "POST /create" do
    it "returns http success" do
      expect{
        post "/api/v1/whispers",
          params: {
            whisper: {
              send_user_id: user1.id,
              send_user_name: user1.name,
              receive_user_id: user2.id,
              receive_user_name: user2.name,
              message: "multiwatch2",
            },
          },
        }
      }.to change(Whisper, :count).by(1)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      expect{
        delete "/api/v1/whispers/destroy"
      }.to change(Whisper, :count).by(-1)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /friend_request" do
    it "returns http success" do
      expect{
        post "/api/v1/whispers/friend_request", params: {
          whisper: {
            send_user_id: user1.id,
            send_user_name: user1.name,
            receive_user_name: user2.name,
            message_type: "1",
          },
        }
      }.to change(Whisper, :count).by(1)
      expect(response).to have_http_status(302)
    end
  end

  describe "POST /invite_chat" do
    let!(:friendship) { create(:friendship) }

    it "returns http success" do
      expect{
        post "/api/v1/whispers/invite_chat", params: {
          whisper: {
            receive_user_name: [user2.name],
            message_type: "2",
          },
        }
      }.to change(Whisper, :count).by(1)
      expect(response).to have_http_status(204)
    end
  end
end
