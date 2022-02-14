module YoutubeStubSupport
  def stub_youtube
    result_youtube_channels =
      '{"items":[
        {
          "id": {
            "channelId": "channel_id_0"
          },
          "snippet": {
            "channelId": "channel_id_0",
            "title": "title_0",
            "description": "description_0",
            "thumbnails": {
              "default": {
                "url": "https://yt3.ggpht.com/0"
              }
            },
            "channelTitle": "title_0",
            "liveBroadcastContent": "live"
          }
        },
        {
          "id": {
            "channelId": "channel_id_1"
          },
          "snippet": {
            "channelId": "channel_id_1",
            "title": "title_1",
            "description": "description_1",
            "thumbnails": {
              "default": {
                "url": "https://yt3.ggpht.com/1"
              }
            },
            "channelTitle": "title_1",
            "liveBroadcastContent": "live"
          }
        },
        {
          "id": {
            "channelId": "channel_id_2"
          },
          "snippet": {
            "channelId": "channel_id_2",
            "title": "title_2",
            "description": "description_2",
            "thumbnails": {
              "default": {
                "url": "https://yt3.ggpht.com/2"
              }
            },
            "channelTitle": "title_2",
            "liveBroadcastContent": "live"
          }
        },
        {
          "id": {
            "channelId": "channel_id_3"
          },
          "snippet": {
            "channelId": "channel_id_3",
            "title": "title_3",
            "description": "description_3",
            "thumbnails": {
              "default": {
                "url": "https://yt3.ggpht.com/3"
              }
            },
            "channelTitle": "title_3",
            "liveBroadcastContent": "live"
          }
        },
        {
          "id": {
            "channelId": "channel_id_4"
          },
          "snippet": {
            "channelId": "channel_id_4",
            "title": "title_4",
            "description": "description_4",
            "thumbnails": {
              "default": {
                "url": "https://yt3.ggpht.com/4"
              }
            },
            "channelTitle": "title_4",
            "liveBroadcastContent": "none"
          }
        }
      ]}'

    youtube_videoId_0 =
      '{"items": [
        {
          "id": {
            "videoId": "videoId_0"
          }
        }
      ]}'

    youtube_videoId_1 =
      '{"items": [
        {
          "id": {
            "videoId": "videoId_1"
          }
        }
      ]}'

    youtube_videoId_2 =
    '{"items": [
      {
        "id": {
          "videoId": "videoId_2"
        }
      }
    ]}'

    youtube_videoId_3 =
      '{"items": [
        {
          "id": {
            "videoId": "videoId_3"
          }
        }
      ]}'

    youtube_videoId_4 =
      '{"items": [
        {
          "id": {
            "videoId": "videoId_4"
          }
        }
      ]}'

    WebMock.stub_request(
      :get, youtube_uri
    ).
      with(query: "part=snippet&q=0&type=channel&maxResults=5&key=#{youtube_key}").
      to_return(
        status: 200,
        body: result_youtube_channels
      )

    WebMock.stub_request(
      :get, youtube_uri
    ).
      with(query: "part=snippet&channelId=channel_id_0&type=video&eventType=live&key=#{youtube_key}").
      to_return(
        status: 200,
        body: youtube_videoId_0
      )

    WebMock.stub_request(
      :get, youtube_uri
    ).
      with(query: "part=snippet&channelId=channel_id_1&type=video&eventType=live&key=#{youtube_key}").
      to_return(
        status: 200,
        body: youtube_videoId_1
      )

    WebMock.stub_request(
      :get, youtube_uri
    ).
      with(query: "part=snippet&channelId=channel_id_2&type=video&eventType=live&key=#{youtube_key}").
      to_return(
        status: 200,
        body: youtube_videoId_2
      )

    WebMock.stub_request(
      :get, youtube_uri
    ).
      with(query: "part=snippet&channelId=channel_id_3&type=video&eventType=live&key=#{youtube_key}").
      to_return(
        status: 200,
        body: youtube_videoId_3
      )

    WebMock.stub_request(
      :get, youtube_uri
    ).
      with(query: "part=snippet&channelId=channel_id_4&type=video&eventType=live&key=#{youtube_key}").
      to_return(
        status: 200,
        body: youtube_videoId_4
      )
  end
end

RSpec.configure do |config|
  config.include YoutubeStubSupport
end
