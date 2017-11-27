FactoryGirl.define do
  factory :admin do
    uname {Faker::Lorem.word + Time.now.to_s } 
    email { Faker::Internet.email }
    password {Faker::Internet.password }
  end
end
