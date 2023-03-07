# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    description { Faker::Job.title }
    total_vacancies { Faker::Number.between(from: 1, to: 50) }
    application_date { Faker::Date.between(from: '2022-01-23', to: '2022-01-25') }
    last_application_date { Faker::Date.between(from: '2022-01-25', to: '2022-02-15') }
    area { Faker::Number.between(from: 1, to: 50) }
    location { Faker::Address.full_address }
    salary { Faker::Number.between(from: 1000, to: 5000) }
    external_link { Faker::Internet.domain_name }
  end
end
