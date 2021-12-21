module Multiwatch
  def self.youtube_video(youtube_url)
    url = youtube_url.reject(&:blank?)
    url.map { |url| /v=/.match(url).post_match }
  end

  def self.twitch_user(twitch_url)
    url = twitch_url.reject(&:blank?)
    url.map { |url| /tv./.match(url).post_match }
  end
end
