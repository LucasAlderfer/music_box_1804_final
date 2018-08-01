require 'rails_helper'

describe Song, type: :model do
  describe 'validations' do
    it{should validate_presence_of(:title)}
    it{should validate_presence_of(:length)}
    it{should validate_presence_of(:play_count)}
    xit 'is invalid if rating is outside 0 to 5' do
      artist = Artist.create(name: 'Journey')
      song_1 = artist.songs.create(title: "Don't Stop Believing", length: 320, play_count: 390808, rating:6)

      expect(song_1).to be_invalid
    end
  end

  describe 'relationships' do
    it{should belong_to(:artist)}
  end

  describe 'class methods' do
    it 'can find songs with the same rating as one given' do
      artist = Artist.create(name: 'Journey')
      song_1 = artist.songs.create(title: "Don't Stop Believing", length: 320, play_count: 390808, rating:4)
      song_2 = artist.songs.create(title: "Wheel In The Sky", length: 320, play_count: 390808, rating:4)
      song_3 = artist.songs.create(title: "Worlds Apart", length: 320, play_count: 390808, rating:4)
      song_4 = artist.songs.create(title: "Worlds Apart is the best Journey Song", length: 320, play_count: 390808, rating:4)
      song_5 = artist.songs.create(title: "Stop Believing", length: 320, play_count: 390808, rating:5)

      expect(Song.like_songs(song_1)).to eq [song_2.title, song_3.title, song_4.title]
    end
  end
end
