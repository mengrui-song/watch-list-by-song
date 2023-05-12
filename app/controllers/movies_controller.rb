require 'net/http'
require 'json'

class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    authorize @movie
    @people = fetch_people(@movie)
    @people_as_crew = generate_people_as('crew', @people)
    @people_as_cast = generate_people_as('cast', @people)
  end

  private

  def fetch_people(movie)
    movie_id = movie.tmdb_id
    # search for movies with person_id
    # https://api.themoviedb.org/3/person/1795607/movie_credits?api_key=b04a4d29fa7cbdec4d7960abf964d46f
    # search for people with movie_id
    # https://api.themoviedb.org/3/movie/552532/credits?api_key=b04a4d29fa7cbdec4d7960abf964d46f
    url = URI.parse("https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=#{ENV['TMDB_API_KEY']}")
    response = Net::HTTP.get_response(url)
    JSON.parse(response.body)
  end

  def generate_people_as(job, people)
    result = []
    people[job].each do |person_info|
      profile_url = "https://image.tmdb.org/t/p/w500#{person_info['profile_path']}" if person_info['profile_path']
      person_hash = {
        tmdb_person_id: person_info['id'],
        name: person_info['name'],
        profile_url: profile_url
      }
      person_instance = Person.find_by(person_hash) || Person.create(person_hash)
      @movie = Movie.find(params[:id])
      MovieCrew.find_by(person: person_instance, movie: @movie) || MovieCrew.create(person: person_instance, movie: @movie, job_type: job)
      result << person_instance
    end
    result
  end
end
