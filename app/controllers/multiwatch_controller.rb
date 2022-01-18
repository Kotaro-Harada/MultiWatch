require "open-uri"

class MultiwatchController < ApplicationController
  def home
    @user = current_user
  end

  def watch
    @youtube = /v=/.match(params[:youtube]).post_match if params[:youtube].present?
    @twitch = /tv./.match(params[:twitch]).post_match if params[:twitch].present?
    @niconico = /lv/.match(params[:niconico]).post_match if params[:niconico].present?
  end

  def search_channel
    @follow = Follow.new
    @keyword = params[:keyword]
    @platform = params[:platform].to_i
    case @platform
    when 1
      @channels = youtube_channel(params[:keyword])
    when 2
      @channels = twitch_channel(params[:keyword])
    end
  end
end
