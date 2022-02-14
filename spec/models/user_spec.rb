require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid wihout a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください", "は4文字以上で入力してください")
  end

  it "is invalid if name is less than 3 characters" do
    user = User.new(name: "aaa")
    user.valid?
    expect(user.errors[:name]).to include("は4文字以上で入力してください")
  end

  it "is invalid if name is more than 26 characters" do
    user = User.new(name: "a" * 26)
    user.valid?
    expect(user.errors[:name]).to include("は25文字以内で入力してください")
  end

  it "is valid if name is 4 to 25 characters" do
    user1 = User.new(name: "aaaa")
    user2 = User.new(name: "a" * 25)
    user1.invalid?
    user2.invalid?
    expect(user1.errors[:name]).not_to be_present
    expect(user2.errors[:name]).not_to be_present
  end

  it "is invalid without mail address" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "is invalid if mail address does not have @ or ." do
    user1 = User.new(email: "aaaa")
    user2 = User.new(email: "aaaa@")
    user3 = User.new(email: "aaaa.")
    user1.valid?
    user2.valid?
    user3.valid?
    expect(user1.errors[:email]).to include("は不正な値です")
    expect(user2.errors[:email]).to include("は不正な値です")
    expect(user3.errors[:email]).to include("は不正な値です")
  end

  it "is invalid if mail address does not have character between @ and ." do
    user = User.new(email: "aaaa@.a")
    user.valid?
    expect(user.errors[:email]).to include("は不正な値です")
  end

  it "is invalid if mail address does not have character after ." do
    user = User.new(email: "aaaa@a.")
    user.valid?
    expect(user.errors[:email]).to include("は不正な値です")
  end

  it "is valid if mail address has character after . and between @ and ." do
    user = User.new(email: "a@a.a")
    user.invalid?
    expect(user.errors[:email]).not_to be_present
  end

  it "is invalid without a password" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "is invalid if password is less than 7 characters" do
    user = User.new(password: "aaaaaaa")
    user.valid?
    expect(user.errors[:password]).to include("は8文字以上で入力してください")
  end

  it "is valid if password is more than 8 characters" do
    user = User.new(password: "aaaaaaaa")
    user.invalid?
    expect(user.errors[:password]).not_to be_present
  end

  it "is invalid if password_confirmation does not match password" do
    user = User.new(
      password: "aaaaaaaa",
      password_confirmation: "aaaa"
    )
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end

  it "is valid if password_confirmation matches password" do
    user = User.new(
      password: "aaaaaaaa",
      password_confirmation: "aaaaaaaa"
    )
    user.invalid?
    expect(user.errors[:password_confirmation]).not_to be_present
  end

  context "when a user is already created" do
    before do
      user1 = FactoryBot.create(:user, name: "multiwatch", email: "multi@sample.com")
    end

    it "is invalid if name is duplicated" do
      user2 = FactoryBot.build(:user, name: "multiwatch")
      user2.valid?
      expect(user2.errors[:name]).to include("はすでに存在します")
    end

    it "is invalid if mail address is duplicated" do
      user2 = User.new(email: "multi@sample.com")
      user2.valid?
      expect(user2.errors[:email]).to include("はすでに存在します")
    end
  end

  it "can crate user if params is valid" do
    user = User.new(
      name: "multiwatch",
      email: "multi@sample.com",
      password: "multiwatch"
    )
    expect(user.save).to be_truthy
  end
end
