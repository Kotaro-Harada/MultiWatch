class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  MAX_ROOMS = 3

  has_secure_password
  has_one_attached :avatar, dependent: :destroy
  has_many :follows, dependent: :destroy, foreign_key: "user_id"
  has_many :whispers, foreign_key: "receive_user_id"
  has_many :active_friendships,
    class_name: "Friendship",
    foreign_key: "from_user_id",
    dependent: :destroy
  has_many :passive_friendships,
    class_name: "Friendship",
    foreign_key: "to_user_id",
    dependent: :destroy
  has_many :active_friends, through: :active_friendships, source: :to_user
  has_many :passive_friends, through: :passive_friendships, source: :from_user
  has_many :chats
  has_many :user_rooms
  has_many :rooms, through: :user_rooms

  validates :name,
    presence: true,
    length: { in: 4..25 },
    uniqueness: true
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: VALID_EMAIL_REGEX }
  validates :password,
    length: { minimum: 8 },
    presence: true
  validate :user_has_less_than_five_rooms

  private

  def user_has_less_than_five_rooms
    errors.add("参加できるチャットは５つまでです") if User.rooms.length > MAX_ROOMS
  end
end
