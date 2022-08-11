class Movie < ApplicationRecord
  has_many :bookmarks # movie.bookmarks
  has_many :lists, through: :bookmark # movie.lists

  validates :title, presence: true
  validates :overview, presence: true
  validates :title, uniqueness: true
  validates :overview, presence: true
end
