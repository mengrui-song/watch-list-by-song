# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Bookmark.destroy_all
Movie.destroy_all
List.destroy_all
User.destroy_all

require 'open-uri'
# List.destroy_all

# the Le Wagon copy of the API
url = 'http://tmdb.lewagon.com/movie/top_rated'
response = JSON.parse(URI.open(url).read)

response['results'].each do |movie_hash|
  # create an instance with the hash
  Movie.create!(
    title: movie_hash['title'],
    overview: movie_hash['overview'],
    poster_url: 'https://image.tmdb.org/t/p/w500' + movie_hash['poster_path'],
    rating: movie_hash['vote_average']
  )
end


puts "#{Movie.count} movies have been created!"
user = User.create!(
  email: "summerrock1017@gmail.com",
  password: "123123"
)
puts "Create a user."

mylist = List.create!(
  name: "2023",
  image_url: "https://picsum.photos/200/300",
  user: user
)
puts "A list created!"
Movie.all.each do |movie|
  Bookmark.create!(movie: movie, list: mylist)
end
puts "added movies(bookmarks) to my list."