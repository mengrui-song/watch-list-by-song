require 'net/http'
require 'json'
class PeopleController < ApplicationController

  def show
    @person = Person.find(params[:id])
    authorize @person
    @movies = fetch_movies(@person)
    @movies_as_crew = []
    @movies["crew"].each do |movie_info|
      movie_hash = {
        title: movie_info["title"],
        overview: movie_info["overview"],
        poster_url: "https://image.tmdb.org/t/p/w500" + movie_info["poster_path"],
        rating: movie_info["vote_average"]
      }
      movie_instance = Movie.find_by(title: movie_info["title"], overview: movie_info["overview"]) || Movie.create(movie_hash)
      @movies_as_crew << movie_instance
    end
  end

  private
  def fetch_movies(person)
    person_id = person.tmdb_person_id
    url = URI.parse("https://api.themoviedb.org/3/person/#{person_id}/movie_credits?api_key=#{ENV["TMDB_API_KEY"]}")
    response = Net::HTTP.get_response(url)

    data = JSON.parse(response.body)
  end
  def fetch_movie(id)

  end

end
