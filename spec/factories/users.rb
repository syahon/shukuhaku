FactoryBot.define do
  factory :user do
    trait :main do
      user_name { "MyString" }
      sequence(:mail) { |n| "user#{n}@example.com" }
      password { "password" }
      password_confirmation { "password" }
    end

    trait :other do
      user_name { "Foo" }
      sequence(:mail) { |n| "foo#{n}@bar.com" }
      password { "password" }
      password_confirmation { "password" }
    end
  end
end
