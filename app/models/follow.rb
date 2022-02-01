class Follow < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  belongs_to :user

  validate :already_follow

  def image_url
    image.attached? ?
      Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) : nil
  end

  private

  def already_follow
    errors.add if Follow.find_by(user_id: user_id, channel_id: channel_id)
  end
end
