# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "open-uri"

def attach_image_to_record(attachable)
  term = "headshot"
  url = URI.parse("https://loremflickr.com/400/400/#{CGI.escape(term)}?random=#{rand(100)}")
  filename = File.basename(term)
  file = URI.open(url) # rubocop:disable Security/Open
  attachable.attach(io: file, filename: filename)
end

Coach.destroy_all
10.times do
  coach = Coach.create(name: Faker::Name.name)
  attach_image_to_record(coach.image)
end

Student.destroy_all
10.times do
  student = Student.create(name: Faker::Name.name)
  attach_image_to_record(student.image)
end