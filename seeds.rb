10.times do |user|
  City.create(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence(word_count: 10), email: Faker::Internet.email, age: rand(15..99), city: City.all.sample)
  Tag.create(title: Faker::Book.genre)
end

20.times do |gossip|
  Gossip.create(title: Faker::Quote.yoda, content: Faker::Lorem.sentence(word_count: 10), user: User.all.sample)
end

Gossip.all.each do |gossip|
  (rand(1..3)).times do |index_gossipstags|
    GossipsTag.create(gossip: gossip, tag: Tag.all.sample)
  end
end

(rand(1..10)).times do |message|
  PrivateMessage.create(recipient: User.all.sample, sender: User.all.sample, content: Faker::Lorem.sentence(word_count: 10))
end

#Gossip.all.each do |gossip|
#gossip.tags << Tag.all.sample(rand(1..3))
#end

20.times do |comments|
  TopComment.create(user: User.all.sample, gossip: Gossip.all.sample, content: Faker::Lorem.sentence(word_count: 10))
end
