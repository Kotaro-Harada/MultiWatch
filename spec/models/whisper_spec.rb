require 'rails_helper'

RSpec.describe Whisper, type: :model do
  let!(:user) { create_list(:user, 2) }

  it "is valid if receive_user is found" do
    whisper = Whisper.new(receive_user_name: "multiwatch1")
    whisper.invalid?
    expect(whisper.errors[:receive_user_name]).not_to be_present
  end

  it "is invalid without user name" do
    whisper = Whisper.new(receive_user_name: nil)
    expect(whisper.errors).to be_truthy
  end

  it "is invalid with receive user can not find" do
    whisper = Whisper.new(receive_user_name: "multi")
    expect(whisper.errors).to be_truthy
  end

  it "is valid if message has less than 50 characters" do
    whisper = Whisper.new(receive_user_name: "multiwatch7", message: "a" * 50)
    whisper.invalid?
    expect(whisper.errors).not_to be_falsey
  end

  it "is invalid without message" do
    whisper = Whisper.new(receive_user_name: "multiwatch9", message: nil)
    whisper.valid?
    expect(whisper.errors[:message]).to include("を入力してください")
  end

  it "is invalid if message is more than 51" do
    whisper = Whisper.new(receive_user_name: "multiwatch11", message: "a" * 51)
    whisper.valid?
    expect(whisper.errors[:message]).to include("は50文字以内で入力してください")
  end
end
