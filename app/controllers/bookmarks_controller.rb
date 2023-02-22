require 'open-uri'
require 'json'

class BookmarksController < ApplicationController
  def new
    # @tmdb_api_key = ENV['TMDB_API_KEY']
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
    @bookmark.list = @list
    if @list.list_type == 'movie'
      @bookmark.bookmarkable_type = 'Movie'
    else
      @bookmark.bookmarkable_type = 'Person'
    end
    authorize @bookmark
  end

  def create
    @list = List.find(params[:list_id])
    @comment = params[:bookmark][:comment]
    if @list.list_type == 'movie'
      @movie = save_movie(bookmark_params[:movie].to_hash)
      @bookmark = Bookmark.new(comment: @comment, movie: @movie)
    else
      @person = save_person(bookmark_params[:person].to_hash)
      @bookmark = Bookmark.new(comment: @comment, person: @person)
    end
    @bookmark.list = @list
    authorize @bookmark
    @bookmark.save ? (redirect_to list_path(@list)) : (render :new, status: :unprocessable_entity)
  end

  def show
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
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

  def save_person(person_hash)
    if Person.find_by(person_hash)
      person = Person.find_by(person_hash)
    else
      person = Person.new(person_hash)
      person.save
    end
    person
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, movie: %i[title overview rating poster_url],
                                    person: %i[name tmdb_person_id department profile_url])
  end
end
