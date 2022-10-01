FactoryBot.define do
  factory :room do
    association :user
    room_name { "MyString" }
    introduction { "MyText" }
    price { 1 }
    address { "MyString" }
  end
end
