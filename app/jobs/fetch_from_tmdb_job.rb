class GenerateLowSaturationColorJob < ApplicationJob

  def perform
  end

  private

  def fetch_data(url)
    response = Net::HTTP.get_response(url)
    JSON.parse(response.body)
  end

  def generate_movie_hash(data)
    result = []
    movies[job].each do |movie_info|
      poster_url = "https://image.tmdb.org/t/p/w500#{movie_info['poster_path']}" if movie_info['poster_path']
      movie_hash = {
        tmdb_id: movie_info['id'],
        title: movie_info['title'],
        overview: movie_info['overview'],
        poster_url: poster_url,
        rating: movie_info['vote_average']
      }
      movie_instance = Movie.find_by(movie_hash) || Movie.create(movie_hash)
      @person = Person.find(params[:id])
      MovieCrew.find_by(person: @person, movie: movie_instance) || MovieCrew.create(person: @person, movie: movie_instance, job_type: job)
      result << movie_instance
    end
    result
  end

end