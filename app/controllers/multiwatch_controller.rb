require "api"
require "json"

class MultiwatchController < ApplicationController
  def home
  end

  def watch
    @youtube = /v=/.match(params[:youtube]).post_match if params[:youtube].present?
    @twitch = /tv./.match(params[:twitch]).post_match if params[:twitch].present?
    @niconico = /lv/.match(params[:niconico]).post_match if params[:niconico].present?
  end

  def search_channel
    @keyword = params[:keyword]
    @platform = params[:platform].to_i
    case @platform
    when 1
      @channel = Api.youtube_channel(params[:keyword])
      @channel_video = Api.youtube_video(params[:keyword])
    when 2
      @channel = Api.twitch_channel(params[:keyword])
      @channel_status = Api.twitch_stream(params[:keyword])
    end
  end

  def search

    youtube.key = ENV["YOUTUBE_API_KEY"]
    client = Google::APIClient.new(
      :key => ENV["YOUTUBE_API_KEY"],
      :authorization => nil,
    )
    youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

    return client, youtube
  end

  def main
    client, youtube = search

    begin
      search_responce = client.execute!(
        :api_method => youtube.search.list,
        :parameters => {
          :part => "snippet",
          :q => opts[:q],
          :maxResults => opts[:max_results]
        }
      )

      videos = []
      channels = []
      playlists = []

      search_response.data.items.each do |search_result|
        case search_result.id.kind
          when 'youtube#video'
            videos << "#{search_result.snippet.title} (#{search_result.id.videoId})"
          when 'youtube#channel'
            channels << "#{search_result.snippet.title} (#{search_result.id.channelId})"
          when 'youtube#playlist'
            playlists << "#{search_result.snippet.title} (#{search_result.id.playlistId})"
        end
      end

      puts "Videos:\n", videos, "\n"
      puts "Channels:\n", channels, "\n"
      puts "Playlists:\n", playlists, "\n"
    rescue Google::APIClient::TransmissionError => e
      puts e.result.body
    end
  end
end
