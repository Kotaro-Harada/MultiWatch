class Api::V1::WhispersController < ApplicationController
  def index
    @whisper = Whisper.where(receive_user_name: current_user.name)
    render json: @whisper
  end

  def create
    @whisper = Whisper.new(whisper_params)
    if @whisper.save!
      @new_whisper = Whisper.where(receive_user_name: current_user.name)
      render json: @new_whisper
    end
  end

  def destroy
    if Whisper.destroy_by(receive_user_name: current_user.name)
      @whisper = Whisper.where(receive_user_name: current_user.name)
      render json: @whisper
    end
  end

  private

  def whisper_params
    params.require(:whisper).permit(:message, :send_user_id, :receive_user_name, :send_user_name)
  end
end
