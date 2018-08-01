class Song < ApplicationRecord
  validates_presence_of :title, :length, :play_count
  belongs_to :artist
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
  has_many :genre_songs
  has_many :genres, through: :genre_songs

  before_save :generate_slug


  def to_param
    slug
  end

  def generate_slug
    self.slug = title.parameterize
  end

  def self.like_songs(song)
    select('songs.*').where(rating:song.rating).where.not(title:song.title).pluck(:title)
  end
end
