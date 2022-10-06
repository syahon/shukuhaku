FactoryBot.define do
  factory :room do
    association :user, strategy: :create
    room_name { "MyString" }
    introduction { "MyText" }
    price { 1 }
    address { "MyString" }
    user_id { 1 }
  end
end
