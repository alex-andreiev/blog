# frozen_string_literal: true

20.times do
  User.create(
    email: Faker::Internet.email,
    password: 'password@example.com',
    username: Faker::Internet.username,
    role: 0,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

10.times do
  Category.create(name: Faker::Lorem.word.capitalize)
end

authors = User.last(20)

authors.each do |author|
  author.posts.create(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.sentence(512),
    category_id: rand(1..10)
  )
end
