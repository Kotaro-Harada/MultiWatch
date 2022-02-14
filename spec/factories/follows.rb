FactoryBot.define do
  factory :follow do
    id { 1 }
    name { "title_0" }
    display_name {}
    user_id { 1 }
    platform { true }
    channel_id { "channel_id_0" }
    after :build do |follow|
      image_path = Rails.root.join("spec", "fixtures", "files", "avatar.jpeg")
      image = File.open(image_path)
      follow.image.attach(io: image, filename: "default_icon.jpeg")
    end
  end

  trait :twitch do
    id { 2 }
    name { "title_0" }
    display_name { "title_0" }
    user_id { 1 }
    platform { false }
    channel_id { "channel_id_1" }
    after :build do |follow|
      image_path = Rails.root.join("spec", "fixtures", "files", "avatar.jpeg")
      image = File.open(image_path)
      follow.image.attach(io: image, filename: "default_icon.jpeg")
    end
  end
end
