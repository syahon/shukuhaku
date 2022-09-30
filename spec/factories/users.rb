FactoryBot.define do
  factory :user do
    user_name { "MyString" }
    mail { "MyString" }
    password_digest { "MyString" }
    remember_digest { "MyString" }
  end
end
