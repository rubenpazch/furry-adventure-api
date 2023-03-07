# frozen_string_literal: true

FactoryBot.define do
  factory :jobs_organization, class: Jobs::Organization do
    title { Faker::Company.name }
    location { Faker::Address.full_address }
    logo { Faker::LoremFlickr.image(size: '50x60') }
  end
end
