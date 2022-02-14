require 'rails_helper'

RSpec.describe "UserSettings", type: :feature do
  let!(:user) { create(:user, :attach_avatar) }

  context "change profile" do
    before do
      allow_any_instance_of(ActionDispatch::Request)
        .to receive(:session).and_return(user_id: user.id)
      visit profile_user_path(user.id)
    end

    scenario "change avatar and username" do
      attach_file "user[avatar]", "#{Rails.root}/spec/fixtures/files/avatar.jpeg"
      fill_in "ユーザー名 (4~25文字)", with: "multi"
      find(".update_button").click
      expect(page).to have_content "変更が完了しました"
    end

    scenario "fail to change username" do
      fill_in "ユーザー名 (4~25文字)", with: "mul"
      find(".update_button").click
      expect(page).to have_content "ユーザー名は4文字以上で入力してください"
      expect(page).to have_content "multiwatch"
    end
  end

  context "change security" do
    before do
      allow_any_instance_of(ActionDispatch::Request)
        .to receive(:session).and_return(user_id: user.id)
      visit security_user_path(user.id)
    end

    scenario "change mailadress" do
      fill_in "メールアドレス", with: "multiwatch@sample.com"
      find(".mail_address").click
      expect(page).to have_content "変更が完了しました"
    end

    scenario "change password" do
      fill_in "パスワード (8文字以上)", with: "multiwatch"
      fill_in "パスワード(確認)", with: "multiwatch"
      find(".password").click
      expect(page).to have_content "変更が完了しました"
    end

    scenario "fail to change mailaddress" do
      fill_in "メールアドレス", with: "multiwatch"
      find(".mail_address").click
      expect(page).to have_content "メールアドレスは不正な値です"
    end

    scenario "fail to change password" do
      fill_in "パスワード (8文字以上)", with: "multi"
      find(".password").click
      expect(page).to have_content "パスワードは8文字以上で入力してください"
      expect(page).to have_content "パスワード(確認)とパスワードの入力が一致しません"
    end
  end
end
