require 'open-uri'
require 'json'

class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
    @movies = Movie.order(title: :asc)
  end

  def create
    @list = List.find(params[:list_id])
		if Movie.where('lower(title) LIKE ?', params[:bookmark][:movie]).first
			@movie = Movie.where('lower(title) LIKE ?', params[:bookmark][:movie]).first
		else
			@movie = fetch_movie(params[:bookmark][:movie])
      @movie.save
		end
    @comment = params[:bookmark][:comment]
    @bookmark = Bookmark.new(movie: @movie, comment: @comment)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to lists_path
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

	def fetch_movie(movie_name)
    url = "https://api.themoviedb.org/3/search/movie?api_key=b04a4d29fa7cbdec4d7960abf964d46f&language=en-US&query=#{movie_name}&page=1&include_adult=false"
    response = JSON.parse(URI.open(url).read)
    movie_hash = response['results'][0]
    @movie = Movie.new(
      title: movie_hash['title'],
      overview: movie_hash['overview'],
      poster_url: "https://image.tmdb.org/t/p/w500#{movie_hash['poster_path']}",
      rating: movie_hash['vote_average']
    )
	end

end
