require 'rails_helper'

describe 'visiting the show show page' do
  context 'as a visitor' do
    it 'can see a songs rating' do
      artist = Artist.create(name: 'Journey')
      song_1 = artist.songs.create(title: "Don't Stop Believing", length: 320, play_count: 390808, rating:2)

      visit song_path(song_1)

      expect(page).to have_content "Rating: #{song_1.rating}"
    end
  end
end
