require "open-uri"

class FollowsController < ApplicationController
  def index
    @follows = current_user.follows
    render json: @follows, methods: [:image_url]
  end

  def create
    @follow = Follow.new(follow_params)
    file_url = URI.open(params[:image_url])
    @follow.image.attach(io: file_url, filename: "#{params[:follow][:name]}.png")
    @follow.save!
    @check_follow = Follow.find_by(user_id: current_user.id, channel_id: params[:follow][:channel_id])
    render json: @check_follow
  end

  def destroy
    @follow = Follow.find_by(user_id: current_user.id, channel_id: params[:channel_id])
    @follow.destroy
    @check_follow = Follow.find_by(user_id: current_user.id, channel_id: params[:channel_id])
    render json: @check_follow
  end

  def check
    @check_follow = Follow.find_by(user_id: current_user.id, channel_id: params[:channel_id])
    render json: @check_follow
  end

  def get_stream
    @youtube_stream = youtube_stream(params[:channel_id])
    render json: @youtube_stream
  end

  private

  def follow_params
    params.require(:follow).permit(:image, :name, :display_name, :user_id, :platform, :channel_id)
  end
end
