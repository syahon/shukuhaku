FactoryBot.define do
  factory :user do
    trait :main do
      user_name { "MyString" }
      sequence(:mail) { |n| "user#{n}@example.com" }
      password { "password" }
      password_confirmation { "password" }
      after(:build) do |user|
        user.image.attach(io: File.open('spec/factories/images/test_dummy.jpg'), filename: 'test_dummy.jpg', content_type: 'image/jpeg')
      end
    end

    trait :other do
      user_name { "Foo" }
      sequence(:mail) { |n| "foo#{n}@bar.com" }
      password { "password" }
      password_confirmation { "password" }
      after(:build) do |user|
        user.image.attach(io: File.open('spec/factories/images/test_dummy.jpg'), filename: 'test_dummy.jpg', content_type: 'image/jpeg')
      end
    end
  end
end
