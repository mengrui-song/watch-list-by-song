class Person < ApplicationRecord
  has_many :bookmarks, as: :bookmarkable # person.bookmarks
  has_many :bookmark_associations, -> { where(bookmarkable_type: 'Person') }, foreign_key: 'bookmarkable_id', class_name: 'Bookmark'
  has_many :lists, through: :bookmarks # person.lists

  validates :tmdb_person_id, presence: true, uniqueness: true
end
