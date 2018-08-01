require 'rails_helper'

describe 'visiting the genre index page' do
  context 'as a visitor' do
    it 'can see all genres' do
      genre_1 = Genre.create(name:'Rock')
      genre_2 = Genre.create(name:'Jazz')

      visit genres_path

      expect(page).to have_content genre_1.name
      expect(page).to have_content genre_2.name
      click_link genre_1.name
      expect(current_path).to eq genre_path(genre_1)
    end
    it 'cannot create a new genre' do
      genre_1 = Genre.create(name:'Rock')
      genre_2 = Genre.create(name:'Jazz')

      visit genres_path

      expect(page).to_not have_button 'Create Genre'
      expect(page).to have_link genre_1.name
      expect(page).to have_link genre_2.name

      #
      #  post genres_path, genre: {name: "new genre"}
      #  expect(response).to_not be_success
      #
    end
  end
  context 'as an admin' do
    it 'can make a new genre' do
      admin = User.create(username: "Dee", password: 'password', role: 1)
      genre_1 = Genre.create(name:'Rock')
      genre_2 = Genre.create(name:'Jazz')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit genres_path

      expect(page).to have_content genre_1.name
      expect(page).to have_content genre_2.name
      fill_in :genre_name, with: 'Classic Rock'
      click_on 'Create Genre'
      expect(current_path).to eq genres_path
      expect(page).to have_content genre_1.name
      expect(page).to have_content genre_2.name
      expect(page).to have_content 'Classic Rock'
    end
  end
end
