# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# sitter

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
end
