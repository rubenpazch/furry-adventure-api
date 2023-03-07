# frozen_string_literal: true

FactoryBot.define do
  factory :privilege, class: Profiles::Privilege do
    name { Faker::Lorem.word }
  end
end
