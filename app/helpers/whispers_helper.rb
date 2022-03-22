module WhispersHelper
  def get_receive_user_id(receive_user_name)
    if User.find_by(name: receive_user_name).present?
      User.find_by(name: receive_user_name).id
    end
  end

  def send_friend_request
    receive_user_id = get_receive_user_id(params[:whisper][:receive_user_name])
    if params[:whisper][:message_type] == "1" &&
      Friendship.find_by(
        from_user_id: current_user.id,
        to_user_id: receive_user_id
      ).blank? &&
      Friendship.find_by(
        from_user_id: receive_user_id,
        to_user_id: current_user.id
      ).blank? &&
      receive_user_id != current_user.id

      Whisper.create(
        send_user_id: params[:whisper][:send_user_id],
        message: "#{current_user.name}からフレンド申請が届きました",
        receive_user_name: params[:whisper][:receive_user_name],
        send_user_name: params[:whisper][:send_user_name],
        receive_user_id: receive_user_id,
        message_type: params[:whisper][:message_type]
      )
    else
      raise StandardError
    end
  end

  def send_chat_invite
    receive_user_id = get_receive_user_id(params[:whisper][:receive_user_name])
    if params[:whisper][:message_type] == "2" && params[:whisper][:receive_user_name].present?
      params[:whisper][:receive_user_name].each do |user_name|
        receive_user_id = get_receive_user_id(user_name)
        chat_user_ids = current_user.room.users.map(&:id)
        if Friendship.find_by(
          from_user_id: current_user.id,
          to_user_id: receive_user_id
        ).present? ||
          Friendship.find_by(
            from_user_id: receive_user_id,
            to_user_id: current_user.id
          ).present?
          if chat_user_ids.none?(receive_user_id)
            Whisper.create(
              send_user_id: current_user.id,
              message: "#{current_user.name}からチャットへの招待が届きました",
              receive_user_name: user_name,
              send_user_name: current_user.name,
              receive_user_id: receive_user_id,
              message_type: params[:whisper][:message_type]
            )
          else
            raise StandardError
          end
        else
          raise StandardError
        end
      end
    else
      raise ArgumentError, "ユーザーを選択して下さい"
    end
  end
end
