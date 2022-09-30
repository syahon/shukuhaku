FactoryBot.define do
  factory :room do
    room_name { "MyString" }
    introduction { "MyText" }
    price { 1 }
    address { "MyString" }
    user { nil }
  end
end
