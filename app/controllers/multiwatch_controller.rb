class MultiwatchController < ApplicationController
include MultiwatchHelper

  def home
    @user = current_user
  end

  def watch
    if params[:youtube].is_a?(Array) ||
      params[:twitch].is_a?(Array) ||
      params[:niconico].is_a?(Array)
      if params[:youtube].reject!(&:blank?).length +
        params[:twitch].reject!(&:blank?).length +
        params[:niconico].reject!(&:blank?).length > 4
        redirect_to root_path
      else
        part_of_url
      end
    else
      part_of_url
    end
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
