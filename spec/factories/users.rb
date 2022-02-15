FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    sequence(:name) { |n| "multiwatch#{n}" }
    sequence(:email) { |n| "multi#{n}@sample.com" }
    password { "multipass" }
    after :build do |user|
      image_path = Rails.root.join("spec", "fixtures", "files", "default_icon.jpeg")
      image = File.open(image_path)
      user.avatar.attach(io: image, filename: "default_icon.jpeg")
    end
  end

  trait :first do
    id { 1 }
    name { "multiwatch1" }
  end

  trait :second do
    id { 2 }
    name { "multiwatch2" }
  end

  trait :with_friend do
    after(:create) { |user| create(:friendship) }
  end

  trait :with_youtube do
    after(:create) { |user| create(:follow, user: user) }
  end

  trait :with_twitch do
    after(:create) { |user| create(:follow, :twitch, user: user) }
  end

  trait :with_whisper_room do
    id { 1 }
    name { "multiwatch1" }
    after(:create) { |user| create(:whisper, user: user) }

    after(:create) { |user| create(:room, users: [user]) }
  end
end
