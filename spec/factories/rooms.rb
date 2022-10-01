FactoryBot.define do
  factory :room do
    association :user
    id { 1 }
    room_name { "MyString" }
    introduction { "MyText" }
    price { 1 }
    address { "MyString" }
    user_id { 1 }
  end
end
