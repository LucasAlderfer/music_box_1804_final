require 'rails_helper'

describe 'visiting the genre show page' do
  context 'as a visitor' do
    it 'can see all songs associated with that genre' do
      genre_1 = Genre.create(name:'Rock')
      genre_2 = Genre.create(name:'Jazz')
      artist = Artist.create(name:'artista')
      song_1 = genre_1.songs.create(title:'hello', length:4, play_count:5, artist:artist)
      song_2 = genre_1.songs.create(title:'goodbye', length:4, play_count:5, artist:artist)
      song_3 = genre_2.songs.create(title:'hi', length:4, play_count:5, artist:artist)

      visit genre_path(genre_1)

      expect(page).to have_content song_1.title
      expect(page).to have_content song_2.title
      expect(page).to_not have_content song_3.title
    end
    it 'can see average rating for all songs in this genre' do
      genre_1 = Genre.create(name:'Rock')
      genre_2 = Genre.create(name:'Jazz')
      artist = Artist.create(name:'artista')
      song_1 = genre_1.songs.create(title:'hello', length:4, play_count:5, artist:artist, rating:2)
      song_2 = genre_1.songs.create(title:'goodbye', length:4, play_count:5, artist:artist, rating:4)
      song_3 = genre_2.songs.create(title:'hi', length:4, play_count:5, artist:artist, rating:4)
      expected = genre_1.average_song_rating

      visit genre_path(genre_1)

      expect(page).to have_content genre_1.average_song_rating
    end
    it 'can see name and rating for song with highest rating in this genre' do
      genre_1 = Genre.create(name:'Rock')
      artist = Artist.create(name:'artista')
      song_1 = genre_1.songs.create(title:'hello', length:4, play_count:5, artist:artist, rating:2)
      song_2 = genre_1.songs.create(title:'goodbye', length:4, play_count:5, artist:artist, rating:4)

      visit genre_path(genre_1)

      expect(page).to have_content "Song With Highest Rating: #{song_2.title}, #{song_2.rating}"
    end
    it 'can see name and rating for song with lowest rating in this genre' do
      genre_1 = Genre.create(name:'Rock')
      artist = Artist.create(name:'artista')
      song_1 = genre_1.songs.create(title:'hello', length:4, play_count:5, artist:artist, rating:2)
      song_2 = genre_1.songs.create(title:'goodbye', length:4, play_count:5, artist:artist, rating:4)

      visit genre_path(genre_1)

      expect(page).to have_content "Song With Lowest Rating: #{song_1.title}, #{song_1.rating}"
    end
  end
end
