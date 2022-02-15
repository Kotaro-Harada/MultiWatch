class Friendship < ApplicationRecord
  belongs_to :from_user, class_name: "User"
  belongs_to :to_user, class_name: "User"

  validates :from_user_id, presence: true
  validates :to_user_id, presence: true
  validate :already_friend

  private

  def already_friend
    if Friendship.find_by(
      from_user_id: to_user_id,
      to_user_id: from_user_id,
    )
      errors.add("すでにフレンド登録しています")
    end
  end
end
