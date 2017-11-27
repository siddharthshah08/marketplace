FactoryGirl.define do
  factory :bid do
    rate { Faker::Commerce.price }
    project
    buyer
  end
end
