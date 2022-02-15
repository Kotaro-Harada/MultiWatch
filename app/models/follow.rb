class Follow < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => :channel_id

  def image_url
    Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
  end
end
