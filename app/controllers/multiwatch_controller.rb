require "api"
require "json"
require "follow"
require "open-uri"
require "user"

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
      @channel = Api.youtube_channel(params[:keyword])
      @channel_video = Api.youtube_video(params[:keyword])
    when 2
      @channel = Api.twitch_channel(params[:keyword])
      @channel_status = Api.twitch_stream(params[:keyword])
    end
  end

  def follow
    @follow = Follow.new(follow_params)
    file_url = URI.open(params[:image_url])
    @follow.image.attach(io: file_url, filename: "#{params[:follow][:name]}.png")
    @follow.save!
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def unfollow
    @follow = Follow.find_by(channel_id: params[:follow][:channel_id], user_id: params[:follow][:user_id], platform: params[:follow][:platform])
    @follow.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  private

  def follow_params
    params.require(:follow).permit(:image, :name, :display_name, :user_id, :platform, :channel_id)
  end
end
