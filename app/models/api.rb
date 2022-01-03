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
    res["items"]
  end

  def self.twitch_channel(keyword)
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
