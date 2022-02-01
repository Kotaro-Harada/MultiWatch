class UserRoomController < ApplicationController
  def destroy
    @user_room = UserRoom.find_by(user_id: current_user.id)
    @room = @user_room.room
    @user_room.destroy
    if @room.users.blank?
      @room.destroy
    end
    render json: @user_room
  end
end
