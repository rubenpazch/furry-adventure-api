FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password_digest { BCrypt::Password.create("MyString") }
    avatar { Faker::Avatar.image(slug: "my-own-slug", size: "50x50") }
    last_login { Faker::Date.backward(days: 5) }
  end
end
