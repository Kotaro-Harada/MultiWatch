class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :comment,
    presence: true,
    length: { maximum: 50 }
end
