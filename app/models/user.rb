class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

  validates :name,
    presence: true,
    length: { in: 4..25 }
  validates :email,
    presence: true,
    uniqueness: true
  validates :password, length: { minimum: 8 }

end
