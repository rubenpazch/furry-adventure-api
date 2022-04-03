FactoryBot.define do
  factory :menus, :class => Profiles::Menu do
    title { Faker::Internet.slug(words: 'foo bar') }
    link_to { Faker::Internet.slug(words: 'foo bar', glue: '/') }
    hasSubMenu { false }
    isRoot { false }
  end
end
