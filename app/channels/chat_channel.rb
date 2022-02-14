class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ChatChannel_#{params[:room_id]}"
  end

  def speak(data)
    ActionCable.server.broadcast("ChatChannel_#{params[:room_id]}", {
      user: data["user"], message: data["message"]
    })
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
