class ApplicationController < ActionController::Base
  helper_method :current_user, :youtube_stream, :twitch_stream, :twitch_description

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def youtube_stream(channel_id)
    params = {
      part: "snippet",
      channelId: channel_id,
      eventType: "live",
      type: "video",
      key: ENV["YOUTUBE_API_KEY"]
    }
    res = JSON.parse(RestClient.get(
      ENV["YOUTUBE_API_URI"], params: params
    ))
    res["items"]
  end

  def twitch_stream(channel_id)
    params = {
      user_id: channel_id
    }
    res = JSON.parse(RestClient.get(
      ENV["TWITCH_API_STREAM"],
      Authorization: "Bearer #{ENV['TWITCH_ACCESS_TOKEN']}",
      "Client-Id": ENV["TWITCH_CLIENT_ID"],
      params: params
    ))
    res["data"]
  end

  def twitch_description(channel_id)
    params = {
      id: channel_id
    }
    res = JSON.parse(RestClient.get(
      ENV["TWITCH_API_URI"],
      Authorization: "Bearer #{ENV['TWITCH_ACCESS_TOKEN']}",
      "Client-Id": ENV["TWITCH_CLIENT_ID"],
      params: params
    ))
    res["data"][0]["description"]
  end
end
