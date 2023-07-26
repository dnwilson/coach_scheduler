FactoryBot.define do
  factory :slot do
    coach { nil }
    start_at { Time.current.beginning_of_hour + 1.hour }

    trait :with_coach do
      coach
    end
  end
end
