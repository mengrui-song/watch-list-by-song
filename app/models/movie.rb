class Movie < ApplicationRecord
  has_many :bookmarks, as: :bookmarkable # movie.bookmarks
  has_many :bookmark_associations, -> { where(bookmarkable_type: 'Movie') }, foreign_key: 'bookmarkable_id', class_name: 'Bookmark'
  has_many :lists, through: :bookmarks # movie.lists
	has_many :movie_crews, dependent: :destroy
	has_many :people, through: :movie_crews

  validates :title, presence: true, uniqueness: { scope: :overview }
  # validates :overview, presence: true
end
