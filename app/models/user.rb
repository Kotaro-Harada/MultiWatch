class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/

  has_secure_password
  has_one_attached :avatar

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
end
