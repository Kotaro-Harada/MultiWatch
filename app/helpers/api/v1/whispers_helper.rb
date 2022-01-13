module Api::V1::WhispersHelper
  def get_receive_user_id(receive_user_name)
    if User.find_by(name: receive_user_name).present?
      User.find_by(name: receive_user_name).id
    end
  end
end
