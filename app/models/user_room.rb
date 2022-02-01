class UserRoom < ApplicationRecord
  MAX_PARTICIPANTS = 10

  belongs_to :user
  belongs_to :room

  validates :user_id,
    presence: true,
    uniqueness: true
  validates :room_id,
    presence: true
  validate :rooms_has_less_than_ten_users

  private

  def rooms_has_less_than_ten_users
    errors.add("参加できるのは10人までです") if room.users.length > MAX_PARTICIPANTS
  end
end
