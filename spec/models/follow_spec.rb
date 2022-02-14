require 'rails_helper'

RSpec.describe Follow, type: :model do
  let!(:user) { create_list(:user, 2) }
  let!(:follow) { create_list(:follow, 2) }

  it "is invalid if channel is already followed" do
    follow = Follow.new(user_id: 1, channel_id: 0)
    follow.valid?
    expect(follow.errors[:user_id]).to be_truthy
  end

  it "is valid if channel is not followed" do
    follow = Follow.new(user_id: 3, channel_id: 0)
    follow.invalid?
    expect(follow).to be_truthy
  end
end
