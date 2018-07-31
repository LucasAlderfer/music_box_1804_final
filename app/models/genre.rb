class Genre < ApplicationRecord
  validates_presence_of :name
  has_many :genre_songs
  has_many :songs, through: :genre_songs

  def average_song_rating
    songs.average(:rating)
  end

  def song_with_highest_rating
    songs.select('songs.*').order('rating desc').limit(1).first
  end

  def song_with_lowest_rating
    songs.select('songs.*').order('rating').limit(1).first
  end

end
