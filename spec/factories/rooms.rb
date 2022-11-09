FactoryBot.define do
  factory :room do
    trait :main do
      association :user, :main, strategy: :create
      room_name { "main room" }
      introduction { "MyText" }
      price { 100 }
      address { "MyString" }

      after(:build) do |room|
        room.image.attach(io: File.open('spec/factories/images/test_dummy.jpg'), filename: 'test_dummy.jpg', content_type: 'image/jpeg')
      end
    end
  end
end
