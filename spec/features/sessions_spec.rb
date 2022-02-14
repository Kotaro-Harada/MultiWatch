require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  let(:user) { create(:user, :attach_avatar) }

  before do
    visit login_path
  end

  scenario "user can login" do
    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password
    click_button "ログイン"

    expect {
      visit root_path
      expect(page).to have_content user.name
    }
  end

  scenario "user can not login with wrong email" do
    fill_in "session_email", with: "aaaa@sample.com"
    fill_in "session_password", with: user.password
    click_button "ログイン"

    expect {
      visit login_path
      expect(page).not_to have_content user.name
    }
  end

  scenario "user can not login with wrong password" do
    fill_in "session_email", with: user.email
    fill_in "session_password", with: "aaaaaaaa"
    click_button "ログイン"

    expect {
      visit login_path
      expect(page).not_to have_content user.name
    }
  end
end
