class FriendshipController < ApplicationController
  def show
    @whisper = Whisper.new
    @active_friends = current_user.active_friends
    @passive_friends = current_user.passive_friends
  end

  def create
    @friend = Friendship.new(friend_params)
    if @friend.save
      @whisper = Whisper.find(params[:id])
      @whisper.destroy
    end
  end

  def destroy
    @active_friendship = Friendship.find_by(
      from_user_id: params[:from_user_id],
      to_user_id: params[:to_user_id])
    @passive_friendship = Friendship.find_by(
      from_user_id: params[:to_user_id],
      to_user_id: params[:from_user_id])
    if @active_friendship
      @active_friendship.destroy
    else
      @passive_friendship.destroy
    end
    redirect_to friendship_path(current_user.id), notice: "フレンドから削除しました"
  end

  def get_active_friends
    @active_friends = current_user.active_friends
    render json: @active_friends
  end

  def get_passive_friends
    @passive_friends = current_user.passive_friends
    render json: @passive_friends
  end

  private

  def friend_params
    params.require(:friendship).permit(:from_user_id, :to_user_id)
  end
end
