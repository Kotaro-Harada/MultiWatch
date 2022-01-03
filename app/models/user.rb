class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/

  has_secure_password
  has_one_attached :avatar, dependent: :destroy
  has_many :follows, dependent: :destroy

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

  def following?(channel_id)
    channel_ids = []
    self.follows.each do |follow|
      channel_ids.push(follow.channel_id)
    end
    channel_ids.include?(channel_id)
  end


end
