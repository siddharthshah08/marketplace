# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'


100.times do |i|
  buyer = Buyer.create!(uname: Faker::Lorem.word + "b_" + i.to_s, email: Faker::Internet.email, password: Faker::Internet.password)  
  seller = Seller.create!(uname: Faker::Lorem.word + "s_" + i.to_s, email: Faker::Internet.email, password: Faker::Internet.password)
  10.times do |j|
       now = DateTime.now
       project =  seller.projects.create!(name: Faker::StarWars.character, description: Faker::Lorem.sentence, status: 'Inactive', starts_at: now, ends_at: now + 10.days, accepting_bids_till: now - 2.hours, lowest_bid_id: 0)
       duration = (project.ends_at - project.starts_at).to_i / (24 * 60 * 60)
       if j % 2 == 0
         i_rate = Faker::Commerce.price
	 i_bid_amount = (i_rate * duration * 8).round(2)  
         bid = buyer.bids.create!(bid_amount: i_bid_amount, rate: i_rate, project_id: project.id, rate_type: 'Hourly', status: 'Open')
         project.lowest_bid_id = bid.id
	 project.save
       else
         i_rate = Faker::Commerce.price
         i_bid_amount = (i_rate * 20).round(2)
	 bid = buyer.bids.create!(bid_amount: i_bid_amount, rate: i_rate, project_id: project.id, rate_type: 'Fixed_rate', status: 'Open')
         project.lowest_bid_id = bid.id
	 project.save
        end
    end
end

