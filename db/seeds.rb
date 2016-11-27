# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
        username: 'stan',
        email:  'stancalderon@gmail.com',
        password: 'password',
        role: 'admin'
)
25.times do
  User.create!(
      username: Faker::Internet.user_name,
      email:  Faker::Internet.email,
      password: 'password',
      confirmed_at: Faker::Time.between(10.days.ago, Date.today, :all)
  )
end

25.times do
  Wiki.create!(
          title: Faker::Hacker.say_something_smart,
          body: Faker::Lorem.paragraph,
          private: false,
          user_id: Faker::Number.between(1, 25)
  )
end


puts "Added #{User.count} users"
puts "Added #{Wiki.count} wiki's"