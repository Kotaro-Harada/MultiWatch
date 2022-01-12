FactoryBot.define do
  factory :whisper do
    send_user_id { 1 }
    receive_user_id { 1 }
    message { "MyString" }
  end
end
