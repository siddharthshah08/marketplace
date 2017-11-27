FactoryGirl.define do
  factory :project do
    name { Faker::StarWars.character }
    description { Faker::Lorem.sentence }
    status { "Inactive" }
    starts_at { Faker::Date.between(Date.today, Date.today + 4) }
    ends_at { Faker::Date.between(Date.today + 4, Date.today + 10) }
    accepting_bids_till { Faker::Date.between(4.days.ago, 2.days.ago) }
    seller
   end
end

