class Bookmark < ApplicationRecord
  belongs_to :list # bookmark.list
  belongs_to :bookmarkable, polymorphic: true
  belongs_to :movie, optional: true, inverse_of: :bookmarks, class_name: 'Movie'
  belongs_to :person, optional: true, inverse_of: :bookmarks, class_name: 'Person'
  # validates :comment, length: { minimum: 6 }
  validates :movie, uniqueness: { scope: :list, allow_nil: true }
  validates :person, uniqueness: { scope: :list, allow_nil: true }

end
