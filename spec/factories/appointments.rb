FactoryBot.define do
  factory :appointment do
    slot { nil }
    student { nil }
    satisfaction { nil }
    completed_at { nil }

    trait :completed do
      student
      satisfaction { rand(5) }
      completed_at { Time.current }
    end
  end
end
