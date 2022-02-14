class Api::V1::WhispersController < ApplicationController
  include Api::V1::WhispersHelper

  def index
    @whispers = current_user.whispers
    render json: @whispers
  end

  def create
    @whisper = Whisper.new(whisper_params)
    if @whisper.save!
      @whispers = current_user.whispers
      render json: @whispers
    end
  end

  def destroy
    if Whisper.destroy_by(receive_user_id: current_user.id)
      @whispers = current_user.whispers
      render json: @whispers
    end
  end

  def friend_request
    send_friend_request
    redirect_to friendship_path(current_user.id), notice: "ウィスパーでフレンド申請を送りました"
  rescue
    redirect_to friendship_path(current_user.id), alert: "ユーザーが見つからない、またはフレンド登録済みです"
  end

  def invite_chat
    send_chat_invite
  end

  private

  def whisper_params
    @receive_user_id = get_receive_user_id(params[:whisper][:receive_user_name])
    params.require(:whisper).permit(:message, :send_user_id, :receive_user_name,
      :send_user_name, :receive_user_id, :message_type).merge(
        receive_user_id: @receive_user_id, send_user_name: current_user.name,
        send_user_id: current_user.id
      )
  end
end
