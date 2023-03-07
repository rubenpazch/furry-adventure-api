# frozen_string_literal: true

FactoryBot.define do
  factory :sub_menus, class: Profiles::SubMenu do
    title { Faker::Internet.slug(words: 'foo bar') }
    link_to { Faker::Internet.slug(words: 'foo bar', glue: '/') }
    hasSubMenu { false }
  end
end
