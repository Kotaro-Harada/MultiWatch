class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/.freeze

  has_secure_password
  has_one_attached :avatar, dependent: :destroy
  has_many :follows, dependent: :destroy
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
  has_one :user_room
  has_one :room, through: :user_room

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
    presence: true,
    allow_nil: true
end
