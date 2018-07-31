require 'rails_helper'

describe 'user sees one song' do
  it 'with title and length' do
    artist = Artist.create(name: 'Journey')
    song_1 = artist.songs.create(title: "Don't Stop Believing", length: 320, play_count: 390808)
    song_2 = artist.songs.create(title: "Anyway You Want It", length: 420, play_count: 67908)

    visit song_path(song_1)

    expect(current_path).to eq("/songs/#{song_1.slug}")

    expect(page).to have_content(song_1.title)
    expect(page).to have_content(song_1.length)
    expect(page).to_not have_content(song_2.title)
    expect(page).to_not have_content(song_2.length)
  end
  it 'can see all the songs genres' do
    artist = Artist.create(name: 'Journey')
    song_1 = artist.songs.create(title: "Don't Stop Believing", length: 320, play_count: 390808)
    genre_1 = song_1.genres.create(name:'Rock')
    genre_2 = song_1.genres.create(name:'Jazz')
    genre_3 = Genre.create(name:'Classical')

    visit song_path(song_1)

    expect(page).to have_content("Genres for this Song:")
    expect(page).to have_content(genre_1.name)
    expect(page).to have_content(genre_2.name)
    expect(page).to_not have_content(genre_3.name)
  end
  xit 'can see other songs with same rating' do
    artist = Artist.create(name: 'Journey')
    song_1 = artist.songs.create(title: "Don't Stop Believing", length: 320, play_count: 390808, rating:4)
    song_2 = artist.songs.create(title: "Wheel In The Sky", length: 320, play_count: 390808, rating:4)
    song_3 = artist.songs.create(title: "Worlds Apart", length: 320, play_count: 390808, rating:4)
    song_4 = artist.songs.create(title: "Worlds Apart is the best Journey Song", length: 320, play_count: 390808, rating:4)
    song_5 = artist.songs.create(title: "Stop Believing", length: 320, play_count: 390808, rating:5)

    visit song_path(song_1)

    expect(page).to have_content("Songs with same rating: #{song_2.title}, #{song_3.title}, #{song_4.title}")
    expect(page).to_not have_content(song_5.name)
  end
end
