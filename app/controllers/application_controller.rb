class ApplicationController < ActionController::Base
  helper_method :current_user, :youtube_video, :twitch_stream, :twitch_description,
    :twitch_channel, :youtube_channel, :youtube_stream

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def youtube_channel(keyword)
    params = {
      part: "snippet",
      q: keyword,
      type: "channel",
      maxResults: 5,
      key: ENV["YOUTUBE_API_KEY"]
    }
    res = JSON.parse(RestClient.get(
      ENV["YOUTUBE_API_URI"], params: params
    ))
    res["items"]
  end

  def youtube_video(channel_id)
    params = {
      part: "snippet",
      channelId: channel_id,
      type: "video",
      key: ENV["YOUTUBE_API_KEY"]
    }
    res = JSON.parse(RestClient.get(
      ENV["YOUTUBE_API_URI"], params: params
    ))
    res["items"][0]["id"]["videoId"]
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
    if res["items"].present?
      res["items"][0]["id"]["videoId"]
    end
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

  def twitch_channel(keyword)
    params = {
      query: keyword,
      first: 5
    }
    res = JSON.parse(RestClient.get(
      ENV["TWITCH_API_CHANNEL"],
      Authorization: "Bearer #{ENV['TWITCH_ACCESS_TOKEN']}",
      "Client-Id": ENV["TWITCH_CLIENT_ID"],
      params: params
    ))
    res["data"]
  end
end
