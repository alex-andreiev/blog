# frozen_string_literal: true

User.create(
  email: 'admin@example.com',
  password: 'admin@example.com',
  username: 'admin',
  role: 1,
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name
)
