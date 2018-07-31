require 'rails_helper'

describe Genre, type: :model do
  describe 'validations' do
    it{should validate_presence_of(:name)}
  end

  describe 'relationships' do
    it{should have_many(:songs)}
    it{should have_many(:songs).through(:genre_songs)}
  end

  describe 'instance methods' do
    it 'can determine the avergae rating for all songs in that genre' do
      genre_1 = Genre.create(name:'Rock')
      artist = Artist.create(name:'artista')
      song_1 = genre_1.songs.create(title:'hello', length:4, play_count:5, artist:artist, rating:2)
      song_2 = genre_1.songs.create(title:'goodbye', length:4, play_count:5, artist:artist, rating:4)
      expected = (song_1.rating + song_2.rating) / (genre_1.songs.count)

      expect(genre_1.average_song_rating).to eq expected
    end
    it 'can determine the name and rating for song with highest rating in this genre' do
      genre_1 = Genre.create(name:'Rock')
      artist = Artist.create(name:'artista')
      song_1 = genre_1.songs.create(title:'hello', length:4, play_count:5, artist:artist, rating:2)
      song_2 = genre_1.songs.create(title:'goodbye', length:4, play_count:5, artist:artist, rating:4)
      expected = song_2

      expect(genre_1.song_with_highest_rating).to eq expected
    end
    it 'can determine the name and rating for song with lowest rating in this genre' do
      genre_1 = Genre.create(name:'Rock')
      artist = Artist.create(name:'artista')
      song_1 = genre_1.songs.create(title:'hello', length:4, play_count:5, artist:artist, rating:2)
      song_2 = genre_1.songs.create(title:'goodbye', length:4, play_count:5, artist:artist, rating:4)
      expected = song_1

      expect(genre_1.song_with_lowest_rating).to eq expected
    end
  end
end
