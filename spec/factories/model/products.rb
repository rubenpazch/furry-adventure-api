FactoryBot.define do
  factory :product do
    title { Faker::Book.title }
    price { Faker::Number.decimal(l_digits: 2) }
    published { false }
    description { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    slug { "testing/productx" }
    sale_price { Faker::Number.decimal(l_digits: 2) }
  end
end
