require 'rails_helper'

RSpec.describe 'Login Form' do 
  before :each do 
    @user = User.create!(name: "Joe", email: "xyz@gmail.com", password: "abcdef", password_confirmation: "abcdef")
    visit "/login"
    fill_in :email, with: "xyz@gmail.com"
    fill_in :password, with: "abcdef"
    click_button "login"
  end 
  
  describe 'when the user logs in' do 
    it 'clicks on a login link' do 
      visit '/'
      expect(current_path).to eq("/")
      expect(page).to have_link("go to login")
      
      click_link "go to login"
      expect(current_path).to eq("/login")
    end 

    it 'fills out email and password' do 
      fill_in :name, with: "Joe"
      fill_in :email, with: "xyz@gmail.com"
      fill_in :password, with: "abcdef"
      fill_in :password_confirmation, with: "abcdef"

      click_button "login"

      expect(current_path).to eq(user_path(@user))
    end 

    it 'sad path' do 
      visit "/login"
      fill_in :name, with: "Joe"
      fill_in :email, with: "xyz@gmail.com"
      fill_in :password, with: ""
      fill_in :password_confirmation, with: "abcdef"

      click_button "login"
      expect(current_path).to eq("/login")
    end 
  end 

  describe 'logout a user' do 
    it 'no longer shows a link to logout for logged in users' do 
      visit '/'

      expect(page).to_not have_button("login")

      expect(page).to have_link("logout")

      click_link "logout"

      expect(current_path).to eq("/")
      expect(page).to have_button("login")
    end 
  end 
end 