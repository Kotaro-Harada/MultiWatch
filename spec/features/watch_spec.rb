require 'rails_helper'

RSpec.describe "Watch", type: :feature do
  before do
    visit root_path
  end

  context "watch youtube" do
    scenario "watch youtube video" do
      find(".youtube1").set("v=watchyoutube")
      find(".submit").click
      save_and_open_page
      within ".video_frame" do
        expect(page).to have_content "watchyoutube"
      end
    end
  end
end
