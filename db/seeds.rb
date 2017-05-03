# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do
  User.create!(
    name: Faker::Name.unique.name,
    uname: Faker::Internet.unique.user_name(5..8),
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(10, 20)
  )
end
users = User.all

standard_user = User.create!(
  name: Faker::Name.unique.name,
  uname: 'standard',
  email: 'standard@test.com',
  password: 'helloworld'
)

admin_user = User.create!(
  name: Faker::Name.unique.name,
  uname: 'admin',
  email: 'admin@test.com',
  password: 'helloworld',
  role: 'admin'
)

premium_user = User.create!(
  name: Faker::Name.unique.name,
  uname: 'premium',
  email: 'premium@test.com',
  password: 'helloworld',
  role: 'premium'
)

15.times do
   Wiki.create!(
     title: Faker::Book.title,
     body: Faker::Hacker.say_something_smart,
     user: users.sample
   )
end

 puts 'Seed finished'
 puts "#{User.count} users created"
 puts "#{Wiki.count} topics created"
