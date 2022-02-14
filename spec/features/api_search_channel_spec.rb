require 'rails_helper'

RSpec.describe "ApiChannels", type: :feature do
  include YoutubeStubSupport
  include TwitchStubSupport

  WebMock.allow_net_connect!

  let!(:youtube_key) { ENV["YOUTUBE_API_KEY"] }
  let!(:youtube_uri) { ENV["YOUTUBE_API_URI"] }
  let!(:twitch_token) { ENV['TWITCH_ACCESS_TOKEN'] }
  let!(:twitch_uri) { ENV["TWITCH_API_URI"] }
  let!(:twitch_client_id) { ENV["TWITCH_CLIENT_ID"] }
  let!(:twitch_channel) { ENV["TWITCH_API_CHANNEL"] }
  let!(:twitch_stream) { ENV["TWITCH_API_CHANNEL"] }

  context "search youtube channel" do
    before do
      WebMock.enable!
      stub_youtube
      visit root_path
      select "YouTube", from: "platform"
      fill_in "keyword", with: "0"
      click_button "button"
    end

    scenario "search youtube channel shows 5 results" do
      expect{
        visit search_channel_muitiwatches_path
        aggregate_failures do
          (0..4).each do |index|
            within ".channel_image" do
              expect(page).to have_selector "img[src$='https://yt3.ggpht.com/#{index}']"
            end
            within ".channel_name" do
              expect(page).to have_content "title_#{index}"
            end
            within ".channel_id" do
              expect(page).to have_content "channel_id_#{index}"
            end
            within ".description" do
              expect(page).to have_content "description_#{index}"
            end
          end
        end
      }
    end

    scenario "if channel is live, sentens is shown and click image or title link to watch page" do
      aggregate_failures do
        image_link = find(".image_watch0")
        title_link = find(".title_watch0")
        expect(image_link[:href]).to eq watch_multiwatches_path(youtube: "v=videoId_0")
        expect(title_link[:href]).to eq watch_multiwatches_path(youtube: "v=videoId_0")
        expect(page.all(".live_status").count).to eq 4
        expect(page).to have_content "ライブ配信中"
      end
    end

    scenario "if channel is not live, click image or title not to link to watch page" do
      expect(page).to have_no_selector ".watch4"
    end
  end

  context "search twitch channel" do
    before do
      stub_twitch
      visit root_path
      select "Twitch", from: "platform"
      fill_in "keyword", with: "0"
      click_button "button"
    end

    scenario "search twitch channel shows 5 results" do
      expect{
        visit search_channel_muitiwatches_path
        aggregate_failures do
          (0..4).each do |index|
            within ".channel_image" do
              expect(page).to have_selector "img[src$='https://static-cdn.jtvnw.net/#{index}']"
            end
            within ".channel_name" do
              expect(page).to have_content "title_#{index}"
            end
            within ".channel_id" do
              expect(page).to have_content "channel_id_#{index}"
            end
            within ".description" do
              expect(page).to have_content "description_#{index}"
            end
          end
        end
      }
    end

    scenario "click image or title link to watch page" do
      aggregate_failures do
        image_link = find(".image_watch0")
        title_link = find(".title_watch0")
        expect(image_link[:href]).to eq watch_multiwatches_path(twitch: "tv/login_0")
        expect(title_link[:href]).to eq watch_multiwatches_path(twitch: "tv/login_0")
      end
    end

    scenario "if channel is live, sentens is shown" do
      expect(page.all(".live_status").count).to eq 4
      expect(page).to have_content "ライブ配信中"
    end
  end
end
