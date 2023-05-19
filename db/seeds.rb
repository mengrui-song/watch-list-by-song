# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Bookmark.destroy_all
Movie.destroy_all
Person.destroy_all
List.destroy_all
User.destroy_all

require 'open-uri'
# List.destroy_all

# # the Le Wagon copy of the API
# url = 'http://tmdb.lewagon.com/movie/top_rated'
# response = JSON.parse(URI.open(url).read)

# response['results'].each do |movie_hash|
#   # create an instance with the hash
#   Movie.create!(
#     title: movie_hash['title'],
#     overview: movie_hash['overview'],
#     poster_url: 'https://image.tmdb.org/t/p/w500' + movie_hash['poster_path'],
#     rating: movie_hash['vote_average']
#   )
# end
# https://api.themoviedb.org/3/movie/top_rated?api_key=b04a4d29fa7cbdec4d7960abf964d46f&language=en-US&page=1

user = User.create!(
  email: "test@gmail.com",
  password: "123123"
)
puts "Demo user created."

def fetch_data(url)
  response = Net::HTTP.get_response(url)
  JSON.parse(response.body)
end

def create_movie_instance(data)
  result = []
  data.each do |movie_hash|
    # create an instance with the hash
    movie = Movie.new(
      title: movie_hash['title'],
      tmdb_id: movie_hash['id'],
      overview: movie_hash['overview'],
      poster_url: 'https://image.tmdb.org/t/p/w500' + movie_hash['poster_path'],
      rating: movie_hash['vote_average']
    )
    if movie.save
      result << movie
    else
      puts movie.errors.full_messages
    end
  end
  result
end

def create_person_instance(data)
  result = []
  data.each do |person_hash|
    # create an instance with the hash
    # puts person_hash['name']
    # puts person_hash['id']
    # puts person_hash['known_for_department']
    # puts 'https://image.tmdb.org/t/p/w500' + person_hash['profile_path']
    profile_url = "https://image.tmdb.org/t/p/w500#{person_hash['profile_path']}" unless person_hash['profile_path'].nil?
    person = Person.create!(
      name: person_hash['name'],
      tmdb_person_id: person_hash['id'],
      department: person_hash['known_for_department'],
      profile_url: profile_url
    )
    result << person
  end
  result
end
top_rated_movies = []
url = URI.parse("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['TMDB_API_KEY']}&language=en-US&page=1")
data = fetch_data(url)
top_rated_movies = create_movie_instance(data['results'])
puts "#{top_rated_movies.count} movies have been created!"

popular_movies = []
# https://api.themoviedb.org/3/movie/popular?api_key=b04a4d29fa7cbdec4d7960abf964d46f&language=en-US&page=1
url = URI.parse("https://api.themoviedb.org/3/movie/popular?api_key=#{ENV['TMDB_API_KEY']}&language=en-US&page=1")
data = fetch_data(url)
popular_movies = create_movie_instance(data['results'])
puts "#{popular_movies.count} movies have been created!"

fav_actors = []
# https://api.themoviedb.org/3/person/popular?api_key=b04a4d29fa7cbdec4d7960abf964d46f&language=en-US&page=1
url = URI.parse("https://api.themoviedb.org/3/person/popular?api_key=#{ENV['TMDB_API_KEY']}&language=en-US&page=1")
data = fetch_data(url)
fav_actors = create_person_instance(data['results'])
puts "#{fav_actors.count} actors/actresses have been created!"

list1 = List.create!(
  name: "Top rated",
  list_type: "movie",
  image_url: GenerateLowSaturationColorJob.perform_now,
  user: user
)
puts "A [Top rated] list created!"

list2 = List.create!(
  name: "Popular Movies",
  list_type: "movie",
  image_url: GenerateLowSaturationColorJob.perform_now,
  user: user
)
puts "A [Popular Movies] list created!"

list3 = List.create!(
  name: "Fav actor/actress",
  list_type: "person",
  image_url: GenerateLowSaturationColorJob.perform_now,
  user: user
)
puts "A [Fav actor/actress] list created!"

top_rated_movies.each do |movie|
  Bookmark.create!(movie: movie, list: list1)
end
puts "added movies to [Top rated] list."

popular_movies.each do |movie|
  Bookmark.create!(movie: movie, list: list2)
end
puts "added movies to [Popular Movies] list."

fav_actors.each do |person|
  Bookmark.create!(person: person, list: list3)
end
puts "added actors/actresses to [Fav actor/actress] list."