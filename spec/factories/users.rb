FactoryBot.define do
    factory :user do |u|
        u.first_name "Onen"
        u.last_name "Julius"
        u.email "jonen54@gmail.com"
        u.password "256thjuly"
        u.date_added Time.now()
        u.created_at Time.now()
        u.updated_at Time.now()
    end
end