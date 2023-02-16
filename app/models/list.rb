class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy # list.bookmarks
  has_many :movies, through: :bookmarks, source: :bookmarkable, source_type: 'Movie' # list.movies
  has_many :persons, through: :bookmarks, source: :bookmarkable, source_type: 'Person' # list.movies

  belongs_to :user #list.user

  validates :name, presence: true
  validates :name, uniqueness: true

  has_one_attached :photo
end
