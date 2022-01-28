class RoomsController < ApplicationController
  def index
    @rooms = current_user.rooms
  end

  def create
    @room = Room.new
    @room.save
  end

  def edit
  end

  def destroy
  end


end
