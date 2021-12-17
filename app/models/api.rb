require "google/apis/youtube_v3"
require "rest-client"
require "json"

class Api < ApplicationRecord
  def self.youtube_channel(keyword)
    params = {
      part: "snippet",
      q: keyword,
      type: "channel",
      maxResults: 5,
      key: ENV["YOUTUBE_API_KEY"]
    }
    JSON.parse(RestClient.get(
      ENV["YOUTUBE_API_URI"], params: params
    ))
  end

  def self.youtube_video(keyword)
    params = {
      part: "snippet",
      q: keyword,
      type: "video",
      maxResults: 5,
      key: ENV["YOUTUBE_API_KEY"]
    }
    res = JSON.parse(RestClient.get(
      ENV["YOUTUBE_API_URI"], params: params
    ))
    res["items"][0]["id"]["videoId"]
  end

  def self.twitch_channel(keyword)
    params = {
      login: keyword
    }
    res = JSON.parse(RestClient.get(
      ENV["TWITCH_API_URI"],
      Authorization: "Bearer #{ENV['TWITCH_ACCESS_TOKEN']}",
      "Client-Id": ENV["TWITCH_CLIENT_ID"],
      params: params
    ))
    res["data"][0]
  end

  def self.twitch_stream(keyword)
    params = {
      user_login: keyword
    }
    res = JSON.parse(RestClient.get(
      ENV["TWITCH_API_STREAM"],
      Authorization: "Bearer #{ENV['TWITCH_ACCESS_TOKEN']}",
      "Client-Id": ENV["TWITCH_CLIENT_ID"],
      params: params
    ))
    res["data"]
  end
end
