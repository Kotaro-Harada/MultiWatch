class Follow < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  belongs_to :user, foreign_key: "user_id"

  validates :name, uniqueness: true
end
