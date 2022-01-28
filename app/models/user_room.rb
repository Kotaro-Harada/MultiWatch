class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user,
    presence: true
  validates :room,
    presence: true
end
