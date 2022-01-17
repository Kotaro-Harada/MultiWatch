class Whisper < ApplicationRecord
  belongs_to :user, foreign_key: "receive_user_id"

  validates :message,
    presence: true,
    length: { maximum: 50 }
  validates :receive_user_name,
    presence: true,
    length: { in: 4..25 }
  validates :send_user_name, presence: true
  validates :send_user_id, presence: true
  validates :receive_user_id, presence: true
  validate :receive_user_must_exist

  private

  def receive_user_must_exist
    errors.add("ユーザーが見つかりません") unless User.find_by!(name: receive_user_name)
  end
end
