class WhisperChannel < ApplicationCable::Channel
  def subscribed
    stream_from "WhisperChannel"
    stream_for current_user.id
  end

  def speak(data)
    ActionCable.server.broadcast("WhisperChannel", { message: data })
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
