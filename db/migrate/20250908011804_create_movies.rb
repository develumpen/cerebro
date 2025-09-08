class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.string :tmdb_id, null: false
      t.string :imdb_id
      t.integer :release_year
      t.string :poster_path
      t.text :overview

      t.timestamps
    end
  end
end
