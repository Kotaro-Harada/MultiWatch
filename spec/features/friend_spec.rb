require 'rails_helper'

RSpec.describe "Friend", js: true, type: :feature do
  let!(:user1) { create(:user, :first) }
  let!(:user2) { create(:user, :second) }

  context "user has a friend" do
    let!(:friendship) { create(:friendship) }

    before do
      allow_any_instance_of(ActionDispatch::Request)
        .to receive(:session).and_return(user_id: 1)
      visit friendship_path(1)
    end

    scenario "page shows friend" do
      expect(page).to have_content "multiwatch2"
      within ".friend_icon" do
        expect(page).to have_selector "img[src$='default_icon.jpeg']"
      end
    end

    scenario "confirmation message" do
      find(".friend_delete").click
      expect{
        expect(page.accept_confirm).to eq "フレンドから削除してもよろしいですか？"
        expect(page).to have_content "フレンドから削除しました"
      }.to change(Friendship, :count).by(-1)
    end

    scenario "whisper to friend" do
      find("#whisper_button").click
      aggregate_failures do
        expect(find(".whisper_box")).to be_visible
        expect(find(".receive_user_name").value).to eq "multiwatch2"
      end
    end
  end

  context "page shows passive friend" do
    let!(:friendship) { create(:friendship) }

    before do
      allow_any_instance_of(ActionDispatch::Request)
        .to receive(:session).and_return(user_id: 2)
      visit friendship_path(2)
    end

    scenario "page shows friend" do
      expect(page).to have_content "multiwatch1"
    end
  end

  context "send friend request" do
    before do
      allow_any_instance_of(ActionDispatch::Request)
        .to receive(:session).and_return(user_id: 1)
      visit friendship_path(1)
    end

    scenario "receive_user exists" do
      expect{
        fill_in "whisper[receive_user_name]", with: "multiwatch2"
        find(".friend_request").click
      }.to change(Whisper, :count).by(1)
    end

    scenario "receive_user does not exist" do
      expect{
        fill_in "whisper[receive_user_name]", with: "multiwatch3"
        find(".friend_request").click
      }.to change(Whisper, :count).by(0)
      expect(page).to have_content "ユーザーが見つからない、またはフレンド登録済みです"
    end

    scenario "user is already friend" do
      FactoryBot.create(:friendship)
      expect{
        fill_in "whisper[receive_user_name]", with: "multiwatch2"
        find(".friend_request").click
      }.to change(Whisper, :count).by(0)
      expect(page).to have_content "ユーザーが見つからない、またはフレンド登録済みです"
    end
  end
end
