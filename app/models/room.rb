class Room < ApplicationRecord
 MAX_PARTICIPANTS = 10

  has_many :users, through: :user_rooms
  has_many :user_rooms
  has_many :chats

  validate :rooms_has_less_than_ten_users

  private

  def rooms_has_less_than_ten_users
    errors.add("参加できるのは10人までです") if room.users.length > MAX_PARTICIPANTS
  end
end
