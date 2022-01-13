class Api::V1::WhispersController < ApplicationController
  include Api::V1::WhispersHelper

  def index
    @whispers = Whisper.where(receive_user_id: current_user.id)
    render json: @whispers
  end

  def create
    @whisper = Whisper.new(whisper_params)
    if @whisper.save!
      @whispers = Whisper.where(receive_user_id: current_user.id)
      render json: @whispers
    end
  end

  def destroy
    if Whisper.destroy_by(receive_user_id: current_user.id)
      @whispers = Whisper.where(receive_user_id: current_user.id)
      render json: @whispers
    end
  end

  private

  def whisper_params
    @receive_user_id = get_receive_user_id(params[:whisper][:receive_user_name])
    params.require(:whisper).permit(:message, :send_user_id, :receive_user_name,
      :send_user_name, :receive_user_id).merge(receive_user_id: @receive_user_id)
  end
end
