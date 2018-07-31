class CreateGenreSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :genre_songs do |t|
      t.references :genre, foreign_key: true
      t.references :song, foreign_key: true
    end
  end
end
