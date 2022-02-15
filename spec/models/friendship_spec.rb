require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let!(:user) { create_list(:user, 2) }

  context "users are not friend" do
    it "is valid if users are not friend" do
      friendship = Friendship.new(from_user_id: 1, to_user_id: 2)
      expect(friendship.errors).not_to be_falsey
    end
  end

  context "users are already friend" do
    FactoryBot.build(:friendship, from_user_id: 1, to_user_id: 2)

    it "is invalid if users are already active friend" do
      friendship = Friendship.new(from_user_id: 1, to_user_id: 2)
      expect(friendship.errors).to be_truthy
    end

    it "is invalid if users are already passive friend" do
      friendship = Friendship.new(from_user_id: 2, to_user_id: 1)
      expect(friendship.errors).to be_truthy
    end
  end
end
