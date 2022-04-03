FactoryBot.define do
  factory :role, :class => Profiles::Role do
    name { Faker::Lorem.word }
    is_root { false }
    parent_id { 0 }
  end
end
