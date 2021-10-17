# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    task
    user
  end
end
