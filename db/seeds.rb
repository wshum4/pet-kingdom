# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# sitter
require "open-uri"

puts "Deleting all records..."
Review.delete_all
Request.delete_all
User.delete_all
puts "Records deleted."

puts "Creating Users..."
wince = User.new(
  email: 'wince@email.com',
  password: '123456',
  password_confirmation: '123456',
  sitter: true,
  owner: false,
  address: "1367 1st Avenue, New York, NY 10021",
  details: "An avid dog lover",
  first_name: "Wince",
  last_name: "Shum"
)
file = URI.open("https://res.cloudinary.com/claidy/image/upload/v1597944963/joel-mott-LaK153ghdig-unsplash_ufnf6e.jpg")
wince.photo.attach(io: file, filename: 'wince.jpg', content_type: 'image/jpg')


meagan = User.new(
  email: 'meagan@email.com',
  password: '123456',
  password_confirmation: '123456',
  sitter: true,
  owner: true,
  address: "170 E 76th Street, New York, NY 10075",
  details: "An avid dog lover",
  first_name: "Meagan",
  last_name: "Butters"
)
file = URI.open("https://res.cloudinary.com/claidy/image/upload/v1597944959/zulmaury-saavedra-kXC0dbqtRe4-unsplash_gckapv.jpg")
meagan.photo.attach(io: file, filename: 'meagan.jpg', content_type: 'image/jpg')


daniel = User.new(
  email: 'daniel@email.com',
  password: '123456',
  password_confirmation: '123456',
  sitter: false,
  owner: true,
  address: "240 E 76th Street, New York, NY 10021",
  details: "An avid cat lover",
  first_name: "Daniel",
  last_name: "Lee"
)
file = URI.open("https://res.cloudinary.com/claidy/image/upload/v1597940660/erik-lucatero-d2MSDujJl2g-unsplash_xizsoo.jpg")
daniel.photo.attach(io: file, filename: 'daniel.jpg', content_type: 'image/jpg')

kat = User.new(
  email: 'kat@email.com',
  password: '123456',
  password_confirmation: '123456',
  sitter: true,
  owner: false,
  address: "165A E 73rd Street, New York, NY 10021",
  details: "An avid dog lover",
  first_name: "Ekaterina",
  last_name: "Andriushova"
)
file = URI.open("https://res.cloudinary.com/claidy/image/upload/v1597944968/jamie-brown-wm4DuvIpLj8-unsplash_izndbe.jpg")
kat.photo.attach(io: file, filename: 'kat.jpg', content_type: 'image/jpg')


wince.save
meagan.save
kat.save
daniel.save

owners = [meagan, daniel]
sitters = [meagan, kat, wince]

puts "Creating Requests..."
10.times do
  request = Request.new(
    service: ['Walking', 'Grooming', 'Sitting', 'Cuddling'].sample,
    start_date: DateTime.now,
    end_date: DateTime.now + 1,
    animal: ['cat', 'dog'].sample,
    animal_info: Faker::Creature::Dog.meme_phrase
  )
  request.set_price
  request.owner = owners.sample
  if request.owner == meagan
    request.sitter = [kat, wince].sample
  else
    request.sitter = sitters.sample
  end
  request.save
  if rand(0..5) > 4
    puts "Creating Review..."
    review = Review.new(
      rating: rand(0..5),
      content: Faker::Quote.yoda
    )
    review.request = request
    review.save
  end
end

2.times do 
  req = Request.new(
    service: ['Walking', 'Grooming', 'Sitting', 'Cuddling'].sample,
    start_date: DateTime.now,
    end_date: DateTime.now + 1,
    animal: ['cat', 'dog'].sample,
    animal_info: Faker::Creature::Dog.meme_phrase
  )
  req.set_price
  req.owner = meagan
  req.sitter = [kat, wince].sample
  req.save
end
puts "Finished!"