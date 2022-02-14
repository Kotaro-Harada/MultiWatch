FactoryBot.define do
  factory :room do
    id { 1 }
  end

  trait :with_user_room do
    after(:create) { |room| create(:user_room, room: room) }
  end
end
