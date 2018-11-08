#!/usr/bin/env ruby
require "launchy"

puts "Input your email:"
email = gets.chomp

user = User.find_by(email: email)

puts "What do you want to do?"
puts "0. Create shortened url"
puts "1. Visit shortened url"

command = gets.chomp

if command == "0"
  puts "Type in your long url"
  long_url = gets.chomp
  short_url = ShortenedUrl.create_from_user(user, long_url)

  puts "Short url is #{short_url.short_url}"
  puts "Goodbye!"
elsif command == "1"
  puts "Type in the shortened URL"
  short_url = gets.chomp

  long_url = ShortenedUrl.find_by(short_url: short_url).long_url

  puts "Launching #{long_url} ..."
  Launchy.open(long_url)
  puts "Goodbye!"
end
