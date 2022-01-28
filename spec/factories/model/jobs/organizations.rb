FactoryBot.define do
  factory :organization, :class => Jobs::Organization do
    title { Faker::Company.name }
    location { Faker::Address.full_address }
    logo { Faker::LoremFlickr.image(size: "50x60") }
  end
end
