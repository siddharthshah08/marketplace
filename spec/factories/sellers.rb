FactoryGirl.define do
  sequence(:uname) { |n| "uname#{n}" }
  factory :seller do
    uname 
    email { Faker::Internet.email }
    password {Faker::Internet.password }
  end	
end
