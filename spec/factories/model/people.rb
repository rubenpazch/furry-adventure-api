FactoryBot.define do
  factory :person do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    doc_id { Faker::IDNumber.brazilian_id }
    address { Faker::Address.full_address }
    cell_phone { Faker::PhoneNumber.cell_phone_in_e164 }
    contact_phone { Faker::PhoneNumber.cell_phone_in_e164 }
    district { 1 }
    province { 1 }
    deparment { 1 }
    country { 1 }
    nationality { Faker::Nation.nationality }
    age { Faker::Number.between(from: 1, to: 120) }
    ocupation { Faker::Job.title }
  end
end
