class MultiwatchesController < ApplicationController
  include MultiwatchesHelper

  def home
    @user = current_user
  end

  def watch
    if params[:youtube].is_a?(Array) ||
      params[:twitch].is_a?(Array) ||
      params[:niconico].is_a?(Array)
      params[:youtube].reject! { |youtube| youtube.exclude?("https://www.youtube.com") }
      params[:twitch].reject! { |twitch| twitch.exclude?("https://www.twitch.tv") }
      params[:niconico].reject! { |niconico| niconico.exclude?("https://www.nicovideo.jp") }
      @number_of_videos = params[:youtube].length +
        params[:twitch].length +
        params[:niconico].length
      if @number_of_videos.between?(1, 4)
        part_of_url
      else
        redirect_to root_path, alert: "URLが正しいかどうか、またはURLの数を確認してみて下さい"
      end
    else
      part_of_url
    end
  end

  def search_channel
    if params[:keyword].present?
      @follow = Follow.new
      @platform = params[:platform].to_i
      case @platform
      when 1
        @channels = youtube_channel(params[:keyword])
      when 2
        @channels = twitch_channel(params[:keyword])
      end
    else
      redirect_to root_path
    end
  end

  def concept
  end
end
