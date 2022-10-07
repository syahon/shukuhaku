FactoryBot.define do
  factory :reservation do
    association :user, :main, strategy: :create
    association :room, strategy: :create
    start_date { Date.today.next_day(1) }
    end_date { Date.today.next_day(2) }
    sum_people { 1 }
  end
end
