require 'open-uri'
require 'json'

class BookmarksController < ApplicationController
  before_action :find_list, only: %i[new create]
  before_action :find_movie, only: %i[new create]

  def new
    @bookmark = Bookmark.new
    @bookmark.list = @list
    if @list
      @bookmark.bookmarkable_type = @list.list_type == 'movie' ? 'Movie' : 'Person'
    elsif @movie
      @bookmark.bookmarkable_type = 'Movie'
    end
    authorize @bookmark
  end

  def create
    @comment = bookmark_params[:comment]
    if @list
      case @list.list_type
      when 'movie'
        @movie = save_movie(bookmark_params[:movie].to_hash)
        @bookmark = Bookmark.new(comment: @comment, movie: @movie)
      when 'person'
        @person = save_person(bookmark_params[:person].to_hash)
        @bookmark = Bookmark.new(comment: @comment, person: @person)
      end
      @bookmark.list = @list
    elsif @movie
      @bookmark = Bookmark.new(bookmark_params)
      @bookmark.movie = @movie
      @list = @bookmark.list
    end
    authorize @bookmark
    @bookmark.save ? (redirect_to list_path(@list)) : (render :new, status: :unprocessable_entity)
  end

  # def show
  #   @bookmark = Bookmark.find(params[:id])
  #   authorize @bookmark
  # end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    @bookmark.destroy
    redirect_to lists_path
  end

  private

  def find_list
    @list = List.find(params[:list_id]) if params[:list_id]
  end

  def find_movie
    @movie = Movie.find(params[:movie_id]) if params[:movie_id]
  end

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
    params.require(:bookmark).permit(:comment, :list_id, movie: %i[title overview rating poster_url],
                                    person: %i[name tmdb_person_id department profile_url])
  end
end
