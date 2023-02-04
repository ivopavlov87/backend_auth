if !Rails.env.development?
  puts "[ db/seeds.rb ] Seed data is for develpment only, " +
       "not #{Rails.env}"

  exit 0
end

require "factory_bot"

User.destroy_all

puts "[ db/seeds.rb ] Creating development data..."

User.create!(name: "First Last", email:"first@email.com", username: "seedUser", password: "password123!")

puts "[ db/seeds.rb ] Done"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
