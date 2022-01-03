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

  def following?(channel_name)
    channels = []
    self.follows.each do |follow|
      channels.push(follow.name)
    end
    channels.include?(channel_name)
  end


end
