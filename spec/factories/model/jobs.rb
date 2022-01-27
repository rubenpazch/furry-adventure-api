FactoryBot.define do
  factory :job do
    title { "MyString" }
    description { "MyString" }
    total_vacancies { "" }
    application_date { "2022-01-26" }
    last_application_date { "2022-01-26" }
    area { 1 }
    location { "" }
    salary { "MyString" }
    external_link { "MyString" }
  end
end
