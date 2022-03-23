FactoryBot.define do
  factory :product_category_images, :class => Products::Categories::Image do
    thumbnail { Faker::LoremFlickr.image(size: "50x60") }
    original { Faker::LoremFlickr.image(size: "50x60") }
  end
end
