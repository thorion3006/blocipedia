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

5.times do
  User.create!(
    name: Faker::Name.unique.name,
    uname: Faker::Internet.unique.user_name(5..8),
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(10, 20),
    role: 'admin'
  )
end
admin_users = User.where(role: 'admin')

admin_user = User.create!(
  name: Faker::Name.unique.name,
  uname: 'admin',
  email: 'admin@test.com',
  password: 'helloworld',
  role: 'admin'
)

5.times do
  User.create!(
    name: Faker::Name.unique.name,
    uname: Faker::Internet.unique.user_name(5..8),
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(10, 20),
    role: 'premium'
  )
end
premium_users = User.where(role: 'premium')

premium_user = User.create!(
  name: Faker::Name.unique.name,
  uname: 'premium',
  email: 'premium@test.com',
  password: 'helloworld',
  role: 'premium'
)

paid_users = User.where.not(role: 'standard')

50.times do
   Wiki.create!(
     title: Faker::Book.title,
     body: Faker::Hacker.say_something_smart,
     user: users.sample
   )
end

10.times do
   Wiki.create!(
     title: Faker::Book.title,
     body: Faker::Hacker.say_something_smart,
     user: premium_user
   )
end

50.times do
   Wiki.create!(
     title: Faker::Book.title,
     body: Faker::Hacker.say_something_smart,
     user: paid_users.sample,
     private: true
   )
end

10.times do
   Wiki.create!(
     title: Faker::Book.title,
     body: Faker::Hacker.say_something_smart,
     user: premium_user,
     private: true
   )
end

puts 'Seed finished'
puts "#{admin_users.count} admin users created"
puts "#{premium_users.count} premium users created"
puts "#{User.count} users created"
puts "#{Wiki.where(private: true).count} private wikis created"
puts "#{Wiki.count} wikis created"
