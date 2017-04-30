# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'random_data'

5.times do
  User.create!(
    email: RandomData.random_email,
    password: RandomData.random_sentence
  )
end
users = User.all

15.times do
   Wiki.create!(
     title: RandomData.random_sentence,
     body: RandomData.random_paragraph,
     user: users.sample
   )
end

 puts 'Seed finished'
 puts "#{User.count} users created"
 puts "#{Wiki.count} topics created"
