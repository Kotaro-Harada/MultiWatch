module MultiwatchHelper
  include Rails.application.routes.url_helpers

  def part_of_url
    if params[:youtube].present?
      @youtube = params[:youtube].split if params[:youtube].is_a?(String)
      @youtube = params[:youtube] if params[:youtube].is_a?(Array)
      @youtube.reject!(&:blank?)
      @youtube.map! do |url|
        /v=/.match(url).post_match
      end
    else
      @youtube = []
    end

    if params[:twitch].present?
      @twitch = params[:twitch].split if params[:twitch].is_a?(String)
      @twitch = params[:twitch] if params[:twitch].is_a?(Array)
      @twitch.reject!(&:blank?)
      @twitch.map! do |url|
        /tv./.match(url).post_match
      end
    else
      @twitch = []
    end

    if params[:niconico].present?
      @niconico = params[:niconico].split if params[:niconico].is_a?(String)
      @niconico = params[:niconico] if params[:niconico].is_a?(Array)
      @niconico.reject!(&:blank?)
      @niconico.map! do |url|
        /watch./.match(url).post_match
      end
    else
      @niconico = []
    end
  end
end
