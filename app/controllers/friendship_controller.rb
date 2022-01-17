class FriendshipController < ApplicationController
  def show
    @whisper = Whisper.new
    @active_friends = current_user.active_friends
    @passive_friends = current_user.passive_friends
  end

  def create
    @friend = Friendship.new(friend_params)
    if @friend.save
      whisper = Whisper.find(params[:id])
      whisper.destroy
    end
  end

  def destroy
    @friend = Friendship.find_by(
      from_user_id: params[:from_user_id],
      to_user_id: params[:to_user_id]
    ).destroy
    redirect_to friendship_path(current_user.id), notice: "フレンドから削除しました"
  end

  private

  def friend_params
    params.require(:friendship).permit(:from_user_id, :to_user_id)
  end
end
