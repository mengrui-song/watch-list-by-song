class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.string :comment
      t.references :bookmarkable, polymorphic: true
      t.references :movie, null: true, foreign_key: true
      t.references :person, null: true, foreign_key: true
      t.references :list, null: false, foreign_key: true
      t.timestamps
    end
  end
end
