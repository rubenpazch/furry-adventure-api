FactoryBot.define do
  title_randon = Faker::Lorem.sentence(word_count: 3)

  factory :product do
    title { title_randon }
    price { Faker::Number.decimal(l_digits: 2) }
    published { false }
    description { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    slug { title_randon.downcase.split(' ').join('-') }
    sale_price { Faker::Number.decimal(l_digits: 2) }
  end
end
