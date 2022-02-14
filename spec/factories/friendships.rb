FactoryBot.define do
  factory :friendship do
    from_user_id { 1 }
    to_user_id { 2 }
  end
end
