FactoryBot.define do
  factory :reservation do
    association :user
    association :room
    start_date { "2022-09-30" }
    end_date { "2022-09-30" }
    sum_people { 1 }
  end
end
