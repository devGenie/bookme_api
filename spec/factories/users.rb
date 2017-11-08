require 'faker'
FactoryBot.define do
    factory :user do
        first_name "Onen"
        last_name "Julius"
        email "jonen54@gmail.com"
        password "256thjuly"
        date_added Time.now()
        created_at Time.now()
        updated_at Time.now()

        factory :random_user do
            first_name { Faker::Name.first_name }
            last_name  { Faker::Name.last_name}
            email      { Faker::Internet.email}
            password   "password"
        end
    end
end