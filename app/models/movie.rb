class Movie < ApplicationRecord
  has_many :bookmarks # movie.bookmarks
  has_many :lists, through: :bookmark # movie.lists

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :overview, presence: true
end
