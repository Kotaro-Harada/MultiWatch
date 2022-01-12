require "api"
require "open-uri"
require "user"

class FollowController < ApplicationController
  def new
    @follow = Follow.new
  end

  def create
    @follow = Follow.new(follow_params)
    if params[:follow][:platform].to_s == "true"
      @channel = Api.youtube_channel(params[:follow][:name])
      file_url = URI.open(@channel["items"][0]['snippet']['thumbnails']['default']['url'])
    else
      @channel = Api.twitch_channel(params[:follow][:name])
      file_url = URI.open(@channel['profile_image_url'])
    end
    @follow.image.attach(io: file_url, filename: "#{params[:follow][:name]}.png")
    @follow.save!
  end

  def destroy
    @follow = Follow.find_by(name: params[:name], id: params[:user_id], platform: params[:platform])
    @follow.destroy
  end

  private

  def follow_params
    params.require(:follow).permit(:image, :name, :display_name, :user_id, :platform)
  end
end
