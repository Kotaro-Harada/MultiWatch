module TwitchStubSupport
  def stub_twitch
    result_twitch_channels =
      '{
        "data": [
          {
            "broadcaster_login": "login_0",
            "display_name": "title_0",
            "id": "channel_id_0",
            "is_live": true,
            "thumbnail_url": "https://static-cdn.jtvnw.net/0"
          },
          {
            "broadcaster_login": "login_1",
            "display_name": "title_1",
            "id": "channel_id_1",
            "is_live": true,
            "thumbnail_url": "https://static-cdn.jtvnw.net/1"
          },
          {
            "broadcaster_login": "login_2",
            "display_name": "title_2",
            "id": "channel_id_2",
            "is_live": true,
            "thumbnail_url": "https://static-cdn.jtvnw.net/2"
          },
          {
            "broadcaster_login": "login_3",
            "display_name": "title_3",
            "id": "channel_id_3",
            "is_live": true,
            "thumbnail_url": "https://static-cdn.jtvnw.net/3"
          },
          {
            "broadcaster_login": "login_4",
            "display_name": "title_4",
            "id": "channel_id_4",
            "is_live": false,
            "thumbnail_url": "https://static-cdn.jtvnw.net/4"
          }
        ]
      }'

    twitch_description_0 =
      '{
        "data": [
          {
            "description": "description_0"
          }
        ]
      }'

    twitch_description_1 =
      '{
        "data": [
          {
            "description": "description_1"
          }
        ]
      }'

    twitch_description_2 =
      '{
        "data": [
          {
            "description": "description_2"
          }
        ]
      }'

    twitch_description_3 =
      '{
        "data": [
          {
            "description": "description_3"
          }
        ]
      }'

    twitch_description_4 =
      '{
        "data": [
          {
            "description": "description_4"
          }
        ]
      }'

    WebMock.stub_request(
      :get, twitch_channel
    ).
      with(
        headers: {
          Authorization: "Bearer #{twitch_token}",
          "Client-Id": twitch_client_id,
        },
        query: "query=0&first=5"
      ).to_return(
        status: 200,
        body: result_twitch_channels,
      )

    WebMock.stub_request(
      :get, twitch_uri
    ).
      with(
        headers: {
          Authorization: "Bearer #{twitch_token}",
          "Client-Id": twitch_client_id,
        },
        query: "id=channel_id_0"
      ).to_return(
        status: 200,
        body: twitch_description_0,
      )

    WebMock.stub_request(
      :get, twitch_uri
    ).
      with(
        headers: {
          Authorization: "Bearer #{twitch_token}",
          "Client-Id": twitch_client_id,
        },
        query: "id=channel_id_1"
      ).to_return(
        status: 200,
        body: twitch_description_1,
      )

    WebMock.stub_request(
      :get, twitch_uri
    ).
      with(
        headers: {
          Authorization: "Bearer #{twitch_token}",
          "Client-Id": twitch_client_id,
        },
        query: "id=channel_id_2"
      ).to_return(
        status: 200,
        body: twitch_description_2,
      )

    WebMock.stub_request(
      :get, twitch_uri
    ).
      with(
        headers: {
          Authorization: "Bearer #{twitch_token}",
          "Client-Id": twitch_client_id,
        },
        query: "id=channel_id_3"
      ).to_return(
        status: 200,
        body: twitch_description_3,
      )

    WebMock.stub_request(
      :get, twitch_uri
    ).
      with(
        headers: {
          Authorization: "Bearer #{twitch_token}",
          "Client-Id": twitch_client_id,
        },
        query: "id=channel_id_4"
      ).to_return(
        status: 200,
        body: twitch_description_4,
      )

    WebMock.stub_request(
      :get, twitch_stream
    ).
      with(
        headers: {
          Authorization: "Bearer #{twitch_token}",
          "Client-Id": twitch_client_id,
        },
        query: "user_id=channel_id_1"
      ).to_return(
        status: 200,
        body: '{
          "data": [
            {
              "game_name": "game"
            }
          ]
        }'
      )
  end
end

RSpec.configure do |config|
  config.include TwitchStubSupport
end
