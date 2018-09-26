# frozen_string_literal: true

50.times do
  User.create(
    email: Faker::Internet.email,
    password: 'password@example.com',
    username: Faker::Internet.username,
    role: 0,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end
