FactoryBot.define do
  category_name = Faker::Lorem.sentence(word_count: 3)

  factory :products_category, class: Products::Category do
    title { category_name }
    description { Faker::Lorem.sentence }
    slug { category_name.downcase.split(' ').join('-') }
    product_count { Faker::Number.between(from: 1, to: 100) }
    icon { Faker::LoremFlickr.image(size: '50x60') }
  end
end
