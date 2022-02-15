require 'rails_helper'

RSpec.describe "SideBar", js: true, type: :feature do
  include YoutubeStubSupport
  include TwitchStubSupport

  WebMock.allow_net_connect!

  let!(:youtube_key) { ENV["YOUTUBE_API_KEY"] }
  let!(:youtube_uri) { ENV["YOUTUBE_API_URI"] }
  let!(:twitch_token) { ENV['TWITCH_ACCESS_TOKEN'] }
  let!(:twitch_uri) { ENV["TWITCH_API_URI"] }
  let!(:twitch_client_id) { ENV["TWITCH_CLIENT_ID"] }
  let!(:twitch_channel) { ENV["TWITCH_API_CHANNEL"] }
  let!(:twitch_stream) { ENV["TWITCH_API_STREAM"] }
  let(:user) { create(:user, :with_youtube, :with_twitch) }
  let(:follow) { create(:follow) }
  let(:follow) { create(:follow, :twitch) }

  context "sidebar shows follow channel contents" do
    before do
      allow_any_instance_of(ActionDispatch::Request).
        to receive(:session).and_return(user_id: user.id)
      WebMock.enable!
      stub_youtube
      stub_twitch
      visit root_path
      find(".side_nav").click
    end

    scenario "sidebar shows channel is live" do
      expect(page.all(".live_status").count).to eq 2
    end

    scenario "sidebar shows game name" do
      expect(page).to have_content "game"
    end
  end
end
