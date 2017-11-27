FactoryGirl.define do
  factory :project do
    name { Faker::StarWars.character }
    description { Faker::Lorem.sentence }
    status { "Inactive" }
    starts_at { DateTime.now + 5.days }
    ends_at { DateTime.now + 10.days }
    accepting_bids_till { DateTime.now + 3.days }
    seller
   end
end

