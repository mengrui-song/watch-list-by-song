class Movie < ApplicationRecord
  has_many :bookmarks, as: :bookmarkable # movie.bookmarks
  has_many :bookmark_associations, -> { where(bookmarkable_type: 'Movie') }, foreign_key: 'bookmarkable_id', class_name: 'Bookmark'
  has_many :lists, through: :bookmarks # movie.lists

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  # validates :overview, presence: true
end
