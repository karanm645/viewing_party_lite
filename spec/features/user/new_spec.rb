require 'rails_helper'

RSpec.describe 'viewing party homepage' do
  let!(:user_1) {User.create!(name: "Alfred", email: "alfred@butler.net", status: 0, password_digest: "password1")}
  let!(:user_2) {User.create!(name: "Bruce", email: "bruced@boss.net", status: 0, password_digest: "password2")}
  let!(:user_3) {User.create!(name: "Oswald", email: "oswald@cobblepot.gotham", status: 0, password_digest: "password3")}

  describe 'create a new user' do 
    it 'can fill out the form' do 
      visit "/register"
      expect(current_path).to eq("/register")

      fill_in :name, with: 'Joker'
      fill_in :email, with: 'badman@takeover.edu'
      fill_in :password, with: 'xyxx255'
      fill_in :password_confirmation, with: 'xyxx255'

      click_button "Create New User"
      expect(current_path).to eq(user_path(User.last))

      expect(page).to have_content('Joker')
    end 
  end 

  describe 'sad path' do 
    scenario 'user doesn/t fill out matching passwords' do 
      visit "/register"
      expect(current_path).to eq("/register")
      fill_in :name, with: 'users name'
      fill_in :email, with: 'xyzbadman@gmail.com'
      fill_in :password, with: ''
      fill_in :password_confirmation, with: ''
      click_button "Create New User"
      
      expect(current_path).to eq(register_path)
      expect(page).to have_content 'Fill out the password!'
    end 
  end
end 