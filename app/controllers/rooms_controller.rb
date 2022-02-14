class RoomsController < ApplicationController
  def index
    @room = current_user.room
    render json: @room
  end

  def get_participants
    @participants = current_user.room.users
    render json: @participants
  end

  def create
    ActiveRecord::Base.transaction do
      @room = Room.new
      @room.save
      @room.users << current_user
      render json: @room
    end
  end

  def add_user
    @user = User.find(params[:user_id])
    if @user.room.users << current_user
      @whisper = Whisper.find(params[:whisper_id])
      @whisper.destroy
    end
  end
end
