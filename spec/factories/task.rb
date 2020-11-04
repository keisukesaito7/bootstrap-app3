FactoryBot.define do
  factory :task do
    content               { Faker::Lorem.sentence }
    association :user
  end
end