# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
contract_list = ["full-time", "part-time", "other"]

contract_list.each do |name|
  Contract.create( name: name )
end

user1 = User.create(email: 'moviemaking@movie.com', password: 'moviemaking', name: 'Vin Diesel', locality: 'Hollywood')
user2 = User.create(email: 'nice@photos.com', password: 'nicephotos', name: 'Janda Vocasek', locality: 'Prague')
user3 = User.create(email: 'ilove@pizza.com', password: 'ilovepizza', name: 'Joey Tribiani', locality: 'Brno')

project_list = [
    [user2, 'Photoshoot with with dancers', 'I am looking for some dancers that want some cool photos.', 'Prague'],
    [user3, 'Baking huge pizza', 'I want to find people that love pizza as much as I do. To show how much I care about pizza, I want to make a huge heart-shaped pizza. Wanna join me?', 'Brno']
]

project_list.each do |user, name, description, locality|
  Project.create(author: user, name: name, description: description, locality: locality)
end

project1 = Project.create(author: user1, name: 'Action movie', description: 'Action movie with hot girls and fast cars and guns', locality: 'Hollywood')

position_list = [
    [project1, user1, 'Camera man', 'You should have some experience with filming.'],
    [project1, user1, 'Hot actress', 'You should have some experience with filming.'],
    [project1, user1, 'Hot actor', 'You should have some experience with filming.'],
]

position_list.each do |project, user, name, description|
  Position.create(project: project, user: user, name: name, description: description)
end




