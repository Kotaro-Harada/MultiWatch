FactoryBot.define do
  factory :whisper do
    send_user_id { 2 }
    receive_user_id { 1 }
    send_user_name { "multiwatch2" }
    receive_user_name { "multiwatch1" }
    message { "multiwatch" }
  end
end
