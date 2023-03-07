# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    name { Faker::Lorem.word }
  end
end
