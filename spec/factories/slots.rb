FactoryBot.define do
  factory :slot do
    coach { nil }
    start_at { Time.current.beginning_of_hour + 1.hour }
    # end_at { Time.current.beginning_of_hour + 3.hours }

    trait :with_coach do
      coach
    end
  end
end
