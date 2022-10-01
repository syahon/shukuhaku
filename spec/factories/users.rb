FactoryBot.define do
  factory :user do
    user_name { "MyString" }
    mail { "user@example.com" }
    password { "password" }
    password_confirmation { "password" }
    remember_digest { "MyString" }
  end
end
