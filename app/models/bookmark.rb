class Bookmark < ApplicationRecord
  belongs_to :movie # bookmark.movie
  belongs_to :list # bookmark.list

  # validates :comment, length: { minimum: 6 }
  validates :movie, uniqueness: { scope: :list }

end
