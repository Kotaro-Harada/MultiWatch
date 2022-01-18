class Follow < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  belongs_to :user

  validates :name, uniqueness: true
  validate :already_follow

  private

  def already_follow
    errors.add if Follow.find_by(user_id: user_id, channel_id: channel_id)
  end
end
