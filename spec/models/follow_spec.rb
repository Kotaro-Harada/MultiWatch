require 'rails_helper'

RSpec.describe Follow, type: :model do
  let!(:user) { create(:user, :with_youtube) }
  let!(:user) { create(:user, :second) }

  it "is invalid if channel is already followed" do
    follow = Follow.new(user_id: 1, channel_id: "channel_id_0")
    follow.valid?
    expect(follow.errors[:user_id]).to be_truthy
  end

  it "is valid if channel is not followed" do
    follow = Follow.new(user_id: 2, channel_id: "channel_id_0")
    follow.invalid?
    expect(follow).to be_truthy
  end
end
