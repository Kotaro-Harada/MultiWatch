class ChatsController < ApplicationController
  def index
  end

  def create
    @chat = Chat.new(chat_params)
    @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:user_id, :room_id, :comment).merge(:user_id: current_user.id)
  end
end
