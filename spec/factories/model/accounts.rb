# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    name { Faker::Company.name }
    location { Faker::Address.state }
    address { Faker::Address.full_address }
  end
end
