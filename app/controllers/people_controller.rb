require 'net/http'
require 'json'
class PeopleController < ApplicationController

  def show
    @person = Person.find(params[:id])
    authorize @person
    @movies = fetch_movies(@person)
    @movies_as_crew = generate_movies_as('crew', @movies)
    @movies_as_cast = generate_movies_as('cast', @movies)
  end

  private

  def fetch_movies(person)
    person_id = person.tmdb_person_id
    # search for movies with person_id
    # https://api.themoviedb.org/3/person/1795607/movie_credits?api_key=b04a4d29fa7cbdec4d7960abf964d46f
    # search for people with movie_id
    # https://api.themoviedb.org/3/movie/552532/credits?api_key=b04a4d29fa7cbdec4d7960abf964d46f
    url = URI.parse("https://api.themoviedb.org/3/person/#{person_id}/movie_credits?api_key=#{ENV['TMDB_API_KEY']}")
    response = Net::HTTP.get_response(url)
    JSON.parse(response.body)
  end

  def generate_movies_as(job, movies)
    result = []
    movies[job].each do |movie_info|
      poster_url = "https://image.tmdb.org/t/p/w500#{movie_info['poster_path']}" if movie_info['poster_path']
      movie_hash = {
        tmdb_id: movie_info['id'],
        title: movie_info['title'],
        overview: movie_info['overview'],
        poster_url: poster_url,
        rating: movie_info['vote_average'].floor(1)
      }
      movie_instance = Movie.find_by(tmdb_id: movie_hash[:tmdb_id]) || Movie.create(movie_hash)
      @person = Person.find(params[:id])
      MovieCrew.find_by(person: @person, movie: movie_instance) || MovieCrew.create(person: @person, movie: movie_instance, job_type: job)
      result << movie_instance
    end
    result
  end

end
