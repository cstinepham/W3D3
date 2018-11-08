# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  u1 = User.create!(email: "josh@christine.com")
  u2 = User.create!(email: "abe@lincoln.com")

  link1 = ShortenedUrl.create_from_user(u1, "google.com")
  link2 = ShortenedUrl.create_from_user(u1, "nytimes.com")
  link3 = ShortenedUrl.create_from_user(u2, "cooking.com")

  tag1 = TagTopic.create!(topic: "Search", url_id: link1.id)
  tag2 = TagTopic.create!(topic: "Silicon Valley", url_id: link1.id)
  tag3 = TagTopic.create!(topic: "News", url_id: link2.id)
  tag4 = TagTopic.create!(topic: "Liberal", url_id: link2.id)
