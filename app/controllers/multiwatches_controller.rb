class MultiwatchesController < ApplicationController
  include MultiwatchesHelper

  def home
    @user = current_user
  end

  def watch
    if params[:youtube].is_a?(Array) ||
      params[:twitch].is_a?(Array) ||
      params[:niconico].is_a?(Array)
      if params[:youtube].reject!(&:blank?).length +
        params[:twitch].reject!(&:blank?).length +
        params[:niconico].reject!(&:blank?).length <= 4
        part_of_url
      else
        redirect_to root_path
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
