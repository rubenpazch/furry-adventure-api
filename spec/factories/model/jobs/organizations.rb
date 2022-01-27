FactoryBot.define do
  factory :organization, :class => Jobs::Organization do
    title { "Reniec" }
    location { "ubicacion de la organizacion" }
    logo { "http://www.google.com/log.png" }
  end
end
