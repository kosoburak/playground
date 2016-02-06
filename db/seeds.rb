# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
contract_list = ["part-time", "other"]

Role.find_or_create_by({name: :owner})

contract_list.each do |name|
  Contract.create( name: name )
end

full_contract = Contract.create(name: "full-time")

user1 = User.create(email: 'moviemaking@movie.com', password: 'moviemaking', name: 'Vin Diesel', locality: 'Hollywood', confirmed_at: Time.now)
user2 = User.create(email: 'nice@photos.com', password: 'nicephotos', name: 'Janda Vocasek', locality: 'Prague', confirmed_at: Time.now)
user3 = User.create(email: 'ilove@pizza.com', password: 'ilovepizza', name: 'Joey Tribiani', locality: 'Brno', confirmed_at: Time.now)

project1 = Project.create(author: user1, name: 'Action movie', description: 'Action movie with hot girls and fast cars and guns', locality: 'Hollywood')
project2 = Project.create(author: user2, name: 'Photoshoot with with dancers', description: 'I am looking for some dancers that want some cool photos.', locality: 'Prague')
project3 = Project.create(author: user3, name: 'Baking huge pizza', description: 'I want to find people that love pizza as much as I do. To show how much I care about pizza', locality: 'Brno')

user1.add_role :owner, project1
user2.add_role :owner, project2
user3.add_role :owner, project3

p1 = Position.create(project: project1, contract: full_contract, name: 'Camera man', description: 'You should have some experience with filming.')
p2 = Position.create(project: project1, contract: full_contract, name: 'Hot actress', description: 'You should have some experience with filming.')
p3 = Position.create(project: project1, contract: full_contract, name: 'Hot actor', description: 'You should have some experience with filming.')

message1 = Message.create(from: user1, to: user3, user: user1, text: 'Hi, you are awesome! Wanna play in my movie?', send_time: Time.local(2016,"jan",1,20,15,1), to_name: user3.name, subject: 'Hello')
message1_received = Message.create(from: user1, to: user3, user: user3, text: 'Hi, you are awesome! Wanna play in my movie?', send_time: Time.local(2016,"jan",1,20,15,1), to_name: user3.name, subject: 'Hello')
user1.add_role :owner, message1
user3.add_role :owner, message1_received


message2 = Message.create(from: user3, to: user1, user: user3, text: 'Thanks, your project looks great! I am in', send_time: Time.local(2016,"jan",1,21,15,1), to_name: user1.name, subject: 'Hello')
message2_received = Message.create(from: user3, to: user1, user: user1, text: 'Thanks, your project looks great! I am in', send_time: Time.local(2016,"jan",1,21,15,1), to_name: user1.name, subject: 'Hello')
user3.add_role :owner, message2
user1.add_role :owner, message2_received

message3 = Message.create(from: user1, to: user3, user: user1, text: 'That is great. And we can eat pizza all the time.', send_time: Time.local(2016,"jan",1,22,15,1), to_name: user3.name, subject: 'Hello')
message3_received = Message.create(from: user1, to: user3, user: user3, text: 'That is great. And we can eat pizza all the time.', send_time: Time.local(2016,"jan",1,22,15,1), to_name: user3.name, subject: 'Hello')
user1.add_role :owner, message3
user3.add_role :owner, message3_received