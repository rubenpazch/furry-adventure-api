FactoryBot.define do 
  factory :category, :class => Products::Category do 
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.sentence }
    slug { Faker::Lorem.words(number: 3).join('-') }
    product_count { Faker::Number.between(from: 1, to: 100) }
    icon { Faker::LoremFlickr.image(size: "50x60") } 
  end
end