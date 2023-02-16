require 'open-uri'
require 'json'

class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
    @bookmark.bookmarkable_type = 'Movie'
    # @movie = Movie.new
    # @bookmark.build_movie
    authorize @bookmark
    # @movies = Movie.order(title: :asc)
  end

  def create
    @list = List.find(params[:list_id])
    # bookmark_params
    @movie = save_movie(bookmark_params[:movie].to_hash)
    @comment = params[:bookmark][:comment]
    @bookmark = Bookmark.new(comment: @comment, movie: @movie)
    @bookmark.list = @list
    authorize @bookmark
    @bookmark.save ? (redirect_to list_path(@list)) : (render :new, status: :unprocessable_entity)
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    @bookmark.destroy
    redirect_to lists_path
  end

  private

  def save_movie(movie_hash)
    if Movie.find_by(movie_hash)
      movie = Movie.find_by(movie_hash)
    else
      movie = Movie.new(movie_hash)
      movie.save
    end
    movie
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, movie: %i[title overview rating poster_url])
  end
end
