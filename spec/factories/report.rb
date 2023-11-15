# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    association :user
    title { Faker::Lorem.sentence(word_count: 3) }
    content { Faker::Lorem.paragraph }
  end
end
