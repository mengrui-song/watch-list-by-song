class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :tmdb_person_id
      t.string :name
      t.string :department
      t.string :profile_url
      t.timestamps
    end
  end
end
